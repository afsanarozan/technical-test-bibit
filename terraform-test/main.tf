provider "aws" {
  profile    = "default"
  region     = "ap-southeast-1"
}

resource "aws_lb_target_group" "golang-app-tg" {
  name     = "golang-app-tg"
  port     = 8080
  protocol = "TCP"
  vpc_id   = data.aws_vpc.main.id
  stickiness {
    enabled = false
    type = "source_ip"
  }
}

data "aws_vpc" "main" {
  id       = "${your vpc}"
  tags = {
    Name = "main"
  }
}

data "aws_subnet" "my_subnet" {
  id            = "${your_subnet}"

  tags = {
    Name = "Private subnet"
  }
}

resource "aws_launch_template" "golang-app-lt" {
    name = "golang-app"
    image_id = "${your_ami}"
    instance_type = "c4.large"
    vpc_security_group_ids = ["${your_security_group}"]
    key_name = "k-dev"
    iam_instance_profile {
        name = "ec2-roles"
    }
    placement {
        availability_zone = "ap-southeast-1b"
    }
    block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 100
      volume_type = "gp2"
    }
  }
    user_data = filebase64("run.sh")
    tag_specifications {
        resource_type = "instance"
        tags = {
            Name = "golang-app"
            Project = "test-bibit"
        }
    }
}

resource "aws_autoscaling_group" "golang-app-asg" {
    name                      = "golang-app-asg"
    max_size                  = 3
    min_size                  = 1
    desired_capacity          = 1
    vpc_zone_identifier       = [data.aws_subnet.my_subnet.id]
    launch_template {
        id      = aws_launch_template.golang-app-lt.id
        version = "$Latest"
    }
    target_group_arns = [aws_lb_target_group.golang-app-tg.id]
}

resource "aws_lb_listener_rule" "host_based_weighted_routing" {
  listener_arn = aws_lb_listener.golang-app.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.golang-app-tg.arn
  }

  condition {
    host_header {
      values = ["example.com"]
    }
  }
}
