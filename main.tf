provider "aws" {
  region = "us-east-1"
}

# resource "aws_launch_configuration" "backend" {
#   name_prefix     = "Child-alc"
#   image_id        = var.lt_1_ami_id
#   instance_type   = "t3.medium"
#   security_groups = [var.security_group_id]

#   lifecycle {
#     create_before_destroy = true
#   }
# }


# Launch Template 1
resource "aws_launch_template" "lt_1" {
  name                    = var.launch_template_1_name
  image_id                = var.lt_1_ami_id
  instance_type           = var.instance_type
  key_name                = var.private_key
  vpc_security_group_ids  = [var.security_group_id]

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = var.lt_1_volume_size 
      volume_type           = var.lt_1_volume_type
      delete_on_termination = true
    }
  }

  tags = {
    Name         = var.instance_tag
    environment  = var.environment_tag
    machine_type = var.instance_type
  }
  user_data = filebase64("${path.module}/user_data_scripts/script.sh")
}

# Launch Template 2
resource "aws_launch_template" "lt_2" {
  name          = var.launch_template_2_name
  image_id      = var.lt_2_ami_id
  instance_type = var.instance_type
  key_name      = var.private_key
  vpc_security_group_ids = [var.security_group_id]

    block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = var.lt_2_volume_size
      volume_type           = var.lt_2_volume_type
      delete_on_termination = true
    }
  }

  tags = {
    Name              = var.instance_tag
    environment       = var.environment_tag
    machine_type      = var.instance_type
  }

  # User data script 
  user_data = filebase64("${path.module}/user_data_scripts/script-2.sh")
}

# Auto Scaling Group 1
resource "aws_autoscaling_group" "asg1" {
  name                 = var.as_group_1
  vpc_zone_identifier  = data.aws_subnets.default_subnets.ids 
  target_group_arns    = var.target_group_arns
  # launch_configuration = aws_launch_configuration.backend.id

  launch_template {
    id      = aws_launch_template.lt_1.id 
    version = "$Latest" 
  }

  lifecycle {
    create_before_destroy = true 
  }

  instance_maintenance_policy {
    min_healthy_percentage = 100
    max_healthy_percentage = 110
  }
  min_size              = var.as_group_1_min_size
  max_size              = var.as_group_1_max_size
  desired_capacity      = var.as_group_1_desire_size
  health_check_type     = "EC2"
  termination_policies  = ["OldestInstance"]
}

# Auto Scaling Group 2
resource "aws_autoscaling_group" "asg2" {
  name                  = var.as_group_2
  vpc_zone_identifier   = data.aws_subnets.default_subnets.ids 
  target_group_arns     = var.target_group_arns
  # launch_configuration = aws_launch_configuration.backend.id

  launch_template {
    id      = aws_launch_template.lt_2.id 
    version = "$Latest" 
  }
  lifecycle {
    create_before_destroy = true 
  }
  instance_maintenance_policy {
    min_healthy_percentage = 100
    max_healthy_percentage = 110
  }


  min_size              = var.as_group_2_min_size
  max_size              = var.as_group_2_max_size
  desired_capacity      = var.as_group_2_desire_size
  health_check_type     = "EC2"
  termination_policies  = ["OldestInstance"]
}