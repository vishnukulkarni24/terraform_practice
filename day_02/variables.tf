variable "ami_id"{
  description = "this ami id for instance"

}

variable "instance_type"{
  description = "this is for aws instance type"
}

variable "subnet_id"{
  description = "this is aws subnet id"
}

variable "key_name"{
  description = "this key pair for instance"
}

variable "tag_name"{
  description = "this tag name for instance"
}

variable "instance_count"{
  type = string
}


variable "associate_public_ip_address"{
   type = bool
   default = true
}