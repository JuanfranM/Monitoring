###################
## DEPLOY REGION ##
###################
variable "region" {
  default = "eu-west-1"
}
########################
##SSH KEY EC2 INSTANCE##
########################
variable "rsa_bits" {
  description = "(Optional) When algorithm is \"RSA\", the size of the generated RSA key in bits. Defaults to \"2048\"."
  default     = "2048"
}
variable "namespace" {
  description = "Need the module ssh-key-pair"
  default     = "Infra"
}
variable "stage" {
  description = "Need the module ssh-key-pair"
  default     = "production"
}
variable "server-key-name" {
  description = "Need the module ssh-key-pair"
  default     = "server"
}

########################
##INSTANCIA EC2 CONFIG##
########################
variable "instance_name" {
  description = "The tag Name for instance"
  default     = "Grafana"
}
variable "instance_type" {
  default = "t3.small"
}

variable "instance-type" {
  description = "Instance Type from the server"
  default     = "t3.small"
}
variable "sg_ssh_access" {
  description = "IP whit ssh access the instance server"
  default     = "52.59.163.150/32" 
}
variable "instance_count" {
  description = "Number of instances for deployment"
  default = "1"
}
variable "monitoring" {
  description = "Apply monitoring detailed to 1 min"
  default     = "true"
}
variable "associate_public_ip_address" {
  description = "Attach public IP to the instance (true only if not apply Elastic IP)"
  default = "false"  
}
variable "source_dest_check" {
  description =  "Configure in false only where the instance working with VPN service"
  default     =  "false"
}
variable "ebs_root_size" {
  description = "Customize details about the root block device of the instance."
  default     = "60"
}

########
##TAGS##
########
variable "server_name" {
  description = "(Optional) Name of AWS keypair that will be created"
  default     = "Grafana"
}
variable "env" {
  description = "Environment type"
  default     = "demo"
}
variable "project" {
  description = "Project name"
  default     = "demo"
}
variable "creator" {
  description = "Deploymente by"
  default     = "Reinaldo"
}
variable "terraform" {
  description = "Terraform Template"
  default     = "True"
}
variable "server_userdata" {
  description = "File Script from configure instance"
  default     = "userdata_amz.tpl"
}