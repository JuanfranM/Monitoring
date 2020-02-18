output "server_id" {
  value = "${module.ec2_cluster.id}"
}
output "server_public_ip" {
  value = "${aws_eip.eip_server.id}"
}
output "dns_cname" {
  value = "${aws_route53_record.jenkins.name}"
}

output "server_sg" {
  value = "${module.complete_sg.this_security_group_name}"
}
output "nic_id" {
  value = "${module.ec2_cluster.primary_network_interface_id}"
}