variable "stage" {}
variable "project_name" {}
variable "region" {}


/*
VPC
*/
resource "aws_vpc" "main_vpc" {
  cidr_block                       = "192.168.0.0/16"
  assign_generated_ipv6_cidr_block = false
  instance_tenancy                 = "default"

  tags = {
    Name = "${var.project_name}-${var.stage}-vpc"
  }
}

/*
subnet(public) for EC2
*/

# az ap-northeast-1a
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.stage}-public-subnet-a"
  }
}

# az ap-northeast-1c
resource "aws_subnet" "public_subnet_c" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "192.168.2.0/24"
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.stage}-public-subnet-c"
  }
}

/*
Internet Gateway
*/

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

/*
route table(public)
*/

# route table
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}-public-rtb"
  }
}

# route
resource "aws_route" "public_rtb_route" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

locals {
  public_subnet_ids = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_c.id
  ]
}

# associate public route table with public subnet
resource "aws_route_table_association" "rtb_assoc_public_subnet" {
  count          = 2
  route_table_id = aws_route_table.public_rtb.id
  subnet_id      = element([aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_c.id], count.index)
}
