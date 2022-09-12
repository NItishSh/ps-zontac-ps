resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.zantac_inc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.zantac_inc_igw.id
  }
  tags = {
    "Name"  = "zantac_inc_public_rt"
    "Owner" = "zantac_inc"
  }
}
resource "aws_route_table_association" "public_rt" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
  depends_on     = [aws_route_table.public_rt, aws_subnet.public_subnet]
}
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.zantac_inc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }
  tags = {
    "Name"  = "zantac_inc_private_rt"
    "Owner" = "zantac_inc"
  }
}
resource "aws_route_table_association" "private_rt" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
  depends_on     = [aws_route_table.private_rt, aws_subnet.private_subnet]
}
