variable "project_name" {}
variable "ec2_sg_description" {}
variable "vpc_id" {}
variable "ssh_allow_list" {}
variable "ssh_key_name" {}
variable "ssh_key_path" {}
variable "ami_id" {}
variable "instance_type" {}
variable "public_subnet_id" {}
variable "ebs_volume_type" {}
variable "ebs_volume_size" {}

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

# userdata
data "template_file" "userdata" {
  template = file("${(path.root)}/ec2_userdata/cloud-init.yml")
}

# instance
resource "aws_instance" "ec2_web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2_key_pair.id
  user_data                   = data.template_file.userdata.rendered

  # EBS
  root_block_device {
    volume_type = var.ebs_volume_type
    volume_size = var.ebs_volume_size
  }

  tags = {
    "Name" = "${var.project_name}-ec2"
  }

  //security group
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
}

# Elastic IP
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "ec2_eip" {
  instance = aws_instance.ec2_web.id
  vpc      = true
}