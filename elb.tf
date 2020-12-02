resource "aws_alb" "application_load_balancer" {
  name                        = "load_balancer"
  internal                    = false
  load_balancer_type          = "application"
  availability_zones          = [data.aws_availability_zones.all.names]
  security_groups             = [aws_security_group.elb_security_group.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  subnets                     = aws_subnet.public_subnet.*.id

  access_logs {
    enabled = true
    bucket  = "load_balancer"
    prefix  = "load_balancer/"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  tags = {
    Name        = "load_balancer"
    Enviornment = "production"
  }
}


resource "aws_alb_listener" "application_lb_listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = 80
  protocol          = "http"
}

resource "aws_lb_listener_rule" "admin_rule" {
  listener_arn = aws_lb_listener.application_lb_listener.arn

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "HEALTHY"
      status_code  = "200"
    }
  }

  condition {
    path_pattern {
      values = ["/admin/*"]
    }
  }

  condition {
    query_string {
      key   = "health"
      value = "check"
    }

    query_string {
      value = "bar"
    }
  }
}


resource "aws_lb_target_group_attachment" "alb_admin_tg" {
  target_group_arn = aws_lb_target_gaws_alb_target_grouproup.alb_admin_target_group.arn
  target_id        = aws_instance.test.id
  port             = 80
}
