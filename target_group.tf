resource "aws_alb_target_group" "alb_admin_target_group" {
  name        = "alb_target_group"
  port        = 80
  protocal    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.aws_vpc.id
  stickness   = true


  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }


  tags {
    Name = "alb_target_group"
  }
}

