/*
provider
*/
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}


/*
vpc module
*/
module "vpc" {
  source       = "./modules/vpc"
  stage        = "production"
  project_name = var.project_name
  region       = var.region
}

/*
EC2 module
*/
module "ec2" {
  source             = "./modules/ec2"
  project_name       = var.project_name
  ec2_sg_description = var.ec2_security_group_description
  vpc_id             = module.vpc.vpc_id
  ssh_allow_list     = var.ssh_allow_list
  ssh_key_name       = var.ssh_key_name
  ssh_key_path       = var.ssh_key_path
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  public_subnet_id   = module.vpc.public_subnet_a_id
  ebs_volume_type    = var.ebs_volume_type
  ebs_volume_size    = var.ebs_volume_size
}

/*
Route53 module
*/
module "route53" {
  source       = "./modules/route53"
  host_zone_id = var.host_zone_id
  domain_name  = var.domain_name
  ttl          = var.ttl
  records      = [module.ec2.elastic_ip]
}

/*
SNS module
*/
module "sns" {
  source       = "./modules/sns"
  project_name = var.project_name
  stage        = var.stage
}

/**
SES module
*/
module "ses" {
  source                   = "./modules/ses"
  ses_verify_email_address = var.ses_verify_email_address
  domain_name              = var.domain_name
  dev_domain_name          = var.dev_domain_name
  sns_topic_bounce_arn     = module.sns.sns_topic_bounce_arn
  sns_topic_complaint_arn  = module.sns.sns_topic_complaint_arn
  sns_topic_delivery_arn   = module.sns.sns_topic_complaint_arn
}