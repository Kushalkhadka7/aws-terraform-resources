resource "aws_security_group" "asg_security_group" {
  name        = "asg_security_group"
  description = "Allow traffic only from elastic load balancer"
  vpc_id      = aws_vpc.aws_vpc.vpc_id
  tags = {
    Name = "asg_security_group"
  }

  ingress = {
    security_groups = [aws_security_group.elb_security_group]
    from_port       = 80
    to_port         = 80
    protocol        = "http"
    cidr_blocks     = [aws_vpc.aws_vpc.cidr_block]
  }
}


resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Allow traffic only from auto scaling group"
  vpc_id      = aws_vpc.aws_vpc.vpc_id
  tags = {
    Name = "asg_security_group"
  }

  ingress = {
    security_groups = [aws_security_group.asg_security_group]
    from_port       = 80
    to_port         = 80
    protocol        = "http"
    cidr_blocks     = [aws_vpc.aws_vpc.cidr_block]
  }
}


resource "aws_security_group" "elb_security_group" {
  name        = "elb_security_group"
  description = "Allow traffic from outside the web."
  vpc_id      = aws_vpc.aws_vpc.vpc_id
  tags = {
    Name = "elb_security_group"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
