resource "aws_instance" "admin" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_security_group]
  source_dest_check      = false

  tags = {
    Name = "ec2-admin"
  }
}
