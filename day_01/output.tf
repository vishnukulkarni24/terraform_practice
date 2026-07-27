output "sg_id"{
    description = "sg id in local"
    value = aws_security_group.allow_tls.id
}

output "https_rule_id"{
    value = aws_vpc_security_group_ingress_rule.allow_http.id
}

output "SSH_rule_id"{
    value = aws_vpc_security_group_ingress_rule.ssh_from_internate.id
}

output "public_ip"{
    value = aws_instance.example.public_ip
}