//=============================================================================
// about project
//=============================================================================

variable "project_name" {
  default = "project"
}

variable "stage" {}

//=============================================================================
// region
//=============================================================================

variable "region" {
  default = "ap-northeast-1"
}

//=============================================================================
// AWS credential
//=============================================================================

variable "access_key" {}
variable "secret_key" {}

//=============================================================================
// SSH key
//=============================================================================

variable "ssh_key_name" {}
variable "ssh_key_path" {}

//=============================================================================
// VPC
//=============================================================================

variable "cidr_block" {
  default = "192.168.0.0/16"
}

variable "assign_generated_ipv6_cidr_block" {
  default = false
}

variable "instance_tenancy" {
  default = "default"
}

//=============================================================================
// EC2
//=============================================================================

variable "ec2_security_group_description" {
  default = "security group for EC2"
}

variable "ami_id" {
  default = "ami-06098fd00463352b6"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ebs_volume_type" {
  default = "gp2"
}

variable "ebs_volume_size" {
  default = "8"
}

//=============================================================================
// IP address
//=============================================================================

variable "ip_addresses_to_allow_ssh_access" {
  default = ["0.0.0.0/0"]
}

variable "default_cidr_blocks" {
  default = ["0.0.0.0/0"]
}

//=============================================================================
// RDS
//=============================================================================

variable "db_subnet_group_name" {
  default = "db-subnet-group"
}

variable "db_subnet_group_description" {
  default = "subnet group for RDS"
}

variable "rds_engine" {
  default = "mysql"
}

variable "rds_mysql_version" {}

variable "db_root_user_name" {}

variable "db_root_password" {}

variable "db_instance_class" {
  default = "db.t3.small"
}

variable "db_storage_type" {
  default = "gp2"
}

variable "db_allocated_storage" {
  default = 30
}

variable "rds_security_group_description" {
  default = "security group for RDS"
}

