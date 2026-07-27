output "sg_id"{
    description = "sg id in local"
    value = aws_security_group.aws_tf_sg.id
}

output "https_rule_id"{
    value = aws_vpc_security_group_ingress_rule.allow_http.id
}

output "SSH_rule_id"{
    value = aws_vpc_security_group_ingress_rule.ssh_from_internate.id
}

output "public_ips"{
    value = [
        for instance in aws_instance.tf_instance : instance.public_ip
    ]
}

output "ec2_public_ip_1" {
    value = aws_instance.tf_instance[0].public_ip
}

output "ec2_public_ip_2" {
    value = aws_instance.tf_instance[1].public_ip
}

output "ec2_public_ip_3" {
    value = aws_instance.tf_instance[2].public_ip
}