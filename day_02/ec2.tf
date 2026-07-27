resource "aws_instance" "tf_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  disable_api_termination = false
  vpc_security_group_ids = [aws_security_group.aws_tf_sg.id]
  count = var.instance_count

  user_data = <<-EOT
  #!/bin/bash
  apt update -y
  apt install -y nginx
  systemctl start nginx
  systemctl enable nginx
  echo "<h1>Hello from Terraform Locals Demo environment</h1>" > /var/www/html/index.html
  EOT

  tags = {
    Name = var.tag_name
  }
}