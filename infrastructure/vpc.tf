
provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "zantac_inc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Name"  = "zantac_inc_vpc"
    "Owner" = "zantac_inc"
  }
}
