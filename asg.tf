resource "aws_autoscaling_group" "admin-asg" {
  name                      = "admin-asg"
  availability_zones        = [data.aws_availability_zones.all.names]
  min_size                  = 1
  max_size                  = 3
  health_check_type         = "ELB"
  health_check_grace_period = 300
  desired_capacity          = 1
  launch_configuration      = aws_launch_configuration.admin_asg_launch
  load_balancers            = [aws_elb.load_balancer]

  tag {
    Name                = "admin-asg"
    propagate_at_launch = true
  }
}


resource "aws_launch_configuration" "admin_asg_launch" {
  image_id = "ami-0c55b159cbfafe1f0"

  instance_type   = "t2.micro"
  security_groups = [aws_security_group.asg_security_group]

  lifecycle {
    create_before_destroy = true
  }
}

