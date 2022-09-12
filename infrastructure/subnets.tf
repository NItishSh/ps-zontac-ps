
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.zantac_inc.id
  cidr_block              = var.public_subnet
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    "Name"  = "zantac_inc_public_subnet"
    "Owner" = "zantac_inc"
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.zantac_inc.id
  cidr_block        = var.private_subnet
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    "Name"  = "zantac_inc_private_subnet"
    "Owner" = "zantac_inc"
  }
}
