variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "ami" {
  description = "AMI for the EC2 instance"
  type        = string
  default     = "ami-04aa00acb1165b32a"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}