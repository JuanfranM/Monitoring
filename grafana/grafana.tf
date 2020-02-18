###########################################
##CREATE SECURITY GROUPS FOR EC2 INSTANCE##
###########################################
module "complete_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.0"
  name        = "sg_grafana_jenkins"
  description = "Security group for grafana usage with EC2 instance"
  vpc_id      = "${data.terraform_remote_state.vpc.outputs.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "ssh-tcp"
      cidr_blocks = "${var.sg_ssh_access}"
    },
  ]

  egress_rules = ["all-all"]
}
################################################
##CREATE SSH KEY PAIR FOR THE INSTANCE grafana##
################################################
module "ssh_key_pair" {
  source                = "git::https://github.com/cloudposse/terraform-tls-ssh-key-pair.git?ref=master"
  namespace             = "${var.namespace}"
  stage                 = "${var.stage}"
  name                  = "${var.grafana-key-name}"
  ssh_public_key_path   = "./.key"
  private_key_extension = ".pem"
  public_key_extension  = ".pub"
  chmod_command         = "chmod 600 %v"
}
resource "aws_key_pair" "grafana" {
  key_name   = var.grafana_name
  public_key = module.ssh_key_pair.public_key
}
########################################
##CREATE ROLE IAM FOR grafana INSTANCE##
########################################
resource "aws_iam_role" "server_role" {
  name               = "grafana_role"
  assume_role_policy = file("iam_role.json")
}
resource "aws_iam_instance_profile" "server_profile" {
  name = "grafana_profile"
  role = aws_iam_role.server_role.name
}
###############################################
##CREATE POLICY IAM FOR ROLE INSTANCE##
###############################################
resource "aws_iam_policy" "server_policy" {
  name        = "grafana_policy"
  description = "A bation policy"
  policy      = file("iam_policy.json")
}
resource "aws_iam_policy_attachment" "bation_attach" {
  name       = "server_attachment"
  roles      = ["${aws_iam_role.server_role.name}"]
  policy_arn = aws_iam_policy.server_policy.arn
}

#################################
##IDENTIFIED THE USER-DATA FILE##
#################################
data "template_file" "userdata" {
  template = "${file(var.server_userdata)}"
}
##############################
#CREATE EC2 INSTANCE server##
##############################
module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"
  name    = "${var.instance_name}"

  instance_count              = "${var.instance_count}"
  ami                         = "${data.aws_ami.amazon.id}"
  instance_type               = "${var.instance-type}"
  key_name                    = "${var.server_name}"
  monitoring                  = "${var.monitoring}"
  user_data                   = "${data.template_file.userdata.rendered}"
  iam_instance_profile        = "${aws_iam_instance_profile.server_profile.name}"
  vpc_security_group_ids      = ["${module.complete_sg.this_security_group_id}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  subnet_id                   = "${data.terraform_remote_state.vpc.outputs.public_subnet_ids[2]}"
  source_dest_check           = "${var.source_dest_check}"
  root_block_device           = [{
    volume_size = "${var.ebs_root_size}"
  }]
########
##TAGS##
########
  volume_tags= {
    Terraform   = "${var.terraform}"
    Environment = "${var.env}"
    Create_by   = "${var.creator}"
    Project     = "${var.project}"
    BackupDaily = "True"
  }
  tags = {
    Terraform   = "${var.terraform}"
    Environment = "${var.env}"
    Create_by   = "${var.creator}"
    Project     = "${var.project}"
    BackupDaily = "True"
  }
}