variable "aws_region" {
  type = string
  default = "ap-south-1"
}

variable "ami_id" {
  type = string 
  default = "ami-07a00cf47dbbc844c"
}

variable "instance_type" {
  type = string 
  default = "t3.micro"
}

variable "key_name" {
  sensitive = true
  type = string
  default = "peering-key"
}

variable "subnet_id" {
    type = string
    default = "subnet-077da0f4fef6f78bb"
  
}

variable "instance_name" {
  default = "tf-day-01"
}