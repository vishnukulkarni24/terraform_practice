variable "aws_region" {
  type = string
  default = "ap-south-1"
}

variable "ami_id" {
  type = string 
  default = "ami-01a00762f46d584a1"
}

variable "instance_type" {
  type = string 
  default = "t3.micro"
}

variable "key_name" {
  sensitive = true
  type = string
  default = "ec2-key"
}

variable "subnet_id" {
    type = string
    default = "subnet-004925c5f955ffaea"
  
}

variable "instance_name" {
  default = "tf-depends-on"
}