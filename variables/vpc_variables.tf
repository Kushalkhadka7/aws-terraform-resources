variable "aws_vpc_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

variable "aws_vpc_name" {
  type    = string
  default = "custom_aws_vpc"
}

variable "aws_internet_gateway_name" {
  type    = string
  default = "custom_vpc_internet_gateway"
}

variable "aws_private_subnet_cidr" {
  type    = string
  default = "192.168.1.0/24"
}


variable "aws_public_subnet_cidr" {
  type    = string
  default = "192.168.2.0/24"
}
