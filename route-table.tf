resource "aws_route_table" "aws_public_route_table" {
  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block  = "0.0.0.0/0"
    gatewaty_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "aws_public_route_table"
  }
}


resource "aws_route_table" "aws_private_route_table" {
  default_route_table_id = aws_vpc.aws_vpc.default_route_table_id

  route {
    cidr_block  = "0.0.0.0/0"
    gatewaty_id = aws_internet_gateway.aws_internet_gateway.id
  }

  tags = {
    Name = "aws_private_route_table"
  }
}


resource "aws_main_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.aws_public_route_table.id

  depends_on = [aws_route_table.aws_public_route_table, aws_subnet.public_subnet]
}

resource "aws_main_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.aws_public_route_table.id

  depends_on = [aws_route_table.aws_private_route_table, aws_subnet.private_subnet]
}
