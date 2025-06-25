
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "ec2_ssh" {
    name        = "ec2-ssh-access"
    description = "ho"
    vpc_id      = data.aws_vpc.default.id
}

data "aws_ami" "amazon_linux" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

data "aws_vpc" "default" {
    default = true
}

data "aws_subnet" "default" {
    vpc_id            = data.aws_vpc.default.id

    # Filter to select a single subnet, e.g., the first public subnet in us-east-1a
    filter {
        name   = "availability-zone"
        values = ["us-east-1a"]
    }
}

resource "aws_instance" "ec2_free_tier" {
    ami                    = data.aws_ami.amazon_linux.id
    instance_type          = "t2.micro"
    subnet_id              = data.aws_subnet.default.id
    vpc_security_group_ids = [aws_security_group.ec2_ssh.id]
    key_name               = "eks-key"

    tags = {
        Name = "FreeTierEC2"
    }
}
