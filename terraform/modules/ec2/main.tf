variable "instance_type" {
  description = "Type of instance"
  type = string
}

variable "security_group_id" {
  description = "Security group to associate with the ALB"
  type        = string
}

resource "aws_launch_template" "app_lt" {
  name_prefix   = "cloudops-lt"
  image_id      = "ami-0100e595e1cc1ff7f"  # Amazon Linux 2
  instance_type = var.instance_type
  user_data     = filebase64("user_data.sh")
  vpc_security_group_ids = [var.security_group_id]

  lifecycle {
    create_before_destroy = true
  }
}

output "launch_template_id" {
  value = aws_launch_template.app_lt.id
}