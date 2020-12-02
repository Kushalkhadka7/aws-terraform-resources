resource "aws_autoscaling_group" "admin_asg" {
  name                      = "admin_asg"
  availability_zones        = [data.aws_availability_zones.all.names]
  min_size                  = 1
  max_size                  = 3
  health_check_type         = "ELB"
  health_check_grace_period = 300
  desired_capacity          = 1
  launch_configuration      = aws_launch_configuration.admin_asg_launch.name
  load_balancers            = [aws_elb.load_balancer]
  security_groups           = [aws_security_group.asg_security_group]


  tag {
    Name                = "admin_asg"
    propagate_at_launch = true
  }
}


resource "aws_launch_configuration" "admin_asg_launch" {
  image_id          = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
  security_groups   = [aws_security_group.ec2_security_group.id]
  enable_monitoring = true
  ebs_optimized     = true

  lifecycle {
    create_before_destroy = true
  }

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]
}


resource "aws_autoscaling_policy" "admin_asg_policy" {
  name                    = "admin_asg_policy"
  scaling_adjustment      = 3
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  policy_type             = "SimpleScaling"
  auto_scaling_group_name = aws_autoscaling_group.admin_asg

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40.0
  }
}


resource "aws_autoscaling_attachment" "asg_admin_elb" {
  autoscaling_group_name = aws_autoscaling_group.admin_asg.id
  alb_target_group_arn   = aws_lb_target_group.alb_admin_target_group.arn
}
