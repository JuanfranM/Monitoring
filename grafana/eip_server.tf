################################################
## CREATE EIP AND ASSOCIATED WITH AN INSTANCE ##
################################################
resource "aws_eip" "eip_server" {
  vpc      = true
}
resource "aws_eip_association" "eip_assoc_server" {
  instance_id   = module.ec2_cluster.id[0]
  allocation_id = aws_eip.eip_server.id
}