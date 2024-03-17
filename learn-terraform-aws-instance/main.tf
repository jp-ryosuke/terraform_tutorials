terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to be assigned to the EC2 instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "The ID of the subnet to associate with the EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}


resource "aws_instance" "app_server" {
  //ami                    = "ami-0dfa284c9d7b2adad" //Amazon Linux
  ami                    = "ami-0eba6c58b7918d3a1" //Ubuntu 22.04 LTS
  instance_type          = "t2.micro"
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id

  tags = {
    Name = var.instance_name
  }
}
