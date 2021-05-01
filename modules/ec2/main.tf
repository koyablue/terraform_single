variable "project_name" {}
variable "ec2_sg_description" {}
variable "vpc_id" {}
variable "ssh_allow_list" {}
variable "ssh_key_name" {}
variable "ssh_key_path" {}

/*
security group

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
*/

resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-ec2-sg"
  description = var.ec2_sg_description
  vpc_id      = var.vpc_id

  # HTTP inbound rule
  ingress {
    description      = ""
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # HTTPS inbound rule
  ingress {
    description      = ""
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # SSH inbound rule
  ingress {
    description = ""
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allow_list
  }

  # outbound rule
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}

/*
SSH key

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
*/

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.ssh_key_name
  public_key = file(var.ssh_key_path)
}

/*
EC2 instance

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
*/

