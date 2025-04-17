module "vpc" {
  source = "./modules/vpc"
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow web traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH ACCESS"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.subnet_ids
  security_group_id = aws_security_group.web_sg.id
}

module "ec2" {
  source        = "./modules/ec2"
  instance_type = var.instance_type
  security_group_id = aws_security_group.web_sg.id
}

module "asg" {
  source             = "./modules/asg"
  subnet_ids         = module.vpc.subnet_ids
  target_group_arn   = module.alb.target_group_arn
  launch_template_id = module.ec2.launch_template_id
}
