locals {
  name   = "liujia"
  region = "ap-southeast-1"
  availability_zone = "${local.region}a"

  
  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}