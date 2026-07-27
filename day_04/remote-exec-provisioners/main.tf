
resource "aws_key_pair" "deployer" {
  key_name   = "ssh_key_file"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDdYAvLDZhqxqOUC0X6X6QXQ8XnBmLoFg11i17sGsLgA vishnu@DESKTOP-9JRS8AV"
}

resource "aws_instance" "example" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.file_sg_tf.id]


  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/home/vishnu/tf-b20/day_04/file-provisioners/ssh.key")
    timeout     = "2m"
  }

  # provisioner "file" {
  #   source      = "/home/vishnu/tf-b20/day_04/file-provisioners/demo.txt"
  #   destination = "/home/ubuntu/demo.txt"
  # }

provisioner "remote-exec"{
  inline = [
    "sudo apt update -y",
    "sudo apt install -y nginx",
    "sudo systemctl enable nginx",
    "sudo systemctl start nginx",
    "echo 'Hello from terraform remote-exec' | sudo tee /var/www/html/index.html",
    "sudo apt install git -y"
  
  ]
}




  tags = {
    Name = var.instance_name
  }
}

