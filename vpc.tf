resource "aws_vpc" "aws_vpc" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.aws_vpc_name
  }
}


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = awa_vpc.aws_vpc.id

  tags = {
    Name = var.custom_vpc_internte_gateway
  }
}


resource "aws_nat_gateway" "aws_nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "Nat gateway"
  }
}

resource "aws_eip" "elastic_ip" {
  vpc = true

}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.aws_vpc.id
  cidr_block = var.aws_private_subnet_cidr
}


resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = var.aws_public_subnet_cidr
  map_public_ip_on_launch = true

  depends_on = [aws_internet_gateway.internet_gateway]
}



