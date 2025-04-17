variable "subnet_ids" {
  description = "List of subnet IDs for ALB"
  type        = list(string)
}

variable "launch_template_id" {
  description = "Launch Template ID"
  type        =  string
}

variable "target_group_arn" {
  description = "Target Group ARN"
  type        = string
}



resource "aws_autoscaling_group" "app_asg" {
  desired_capacity     = 2
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = "cloudops-instance"
    propagate_at_launch = true
  }
}

output "asg_name" {
  value = aws_autoscaling_group.app_asg.name
}