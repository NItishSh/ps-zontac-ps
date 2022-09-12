resource "aws_internet_gateway" "zantac_inc_igw" {
  vpc_id = aws_vpc.zantac_inc.id

  tags = {
    "Name"  = "zantac_inc_igw"
    "Owner" = "zantac_inc"
  }
}
