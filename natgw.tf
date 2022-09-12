resource "aws_eip" "nat_eip" {
  tags = {
    "Name"  = "zantac_inc_eip"
    "Owner" = "zantac_inc"
  }
}
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    "Name"  = "zantac_inc_nat_gw"
    "Owner" = "zantac_inc"
  }
}
