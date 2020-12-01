resource "aws_elb" "load_balancer" {
  name                        = "load_balancer"
  availability_zones          = [data.aws_availability_zones.all.names]
  security_groups             = [aws_security_group.elb_security_group]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  subnets                     = [aws_subnet.public_subnet]

  access_logs {
    enabled       = true
    bucket        = "load_balancer"
    bucket_prefix = "load_balancer/"
    interval      = 60
  }

  listener {
    lb_port           = 80
    lb_protocal       = "http"
    instance_port     = 80
    instance_protocal = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  tags = {
    Name = "load_balancer"
  }
}
