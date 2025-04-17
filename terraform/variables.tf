variable "project_name" {
  default = "cloudops-pipeline"
  description = "Name of the project"
  type = string
}

variable "region" {
  default = "us-east-1"
  description = "AWS Region"
  type = string
}

variable "instance_type" {
  default = "t2.micro"
  description = "Type of EC2 instance"
  type = string
}
