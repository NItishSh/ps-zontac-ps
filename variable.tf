variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}
variable "public_subnet" {
  type    = string
  default = "10.0.0.0/17"
}
variable "private_subnet" {
  type    = string
  default = "10.0.128.0/17"
}
variable "web_server_size" {
  type    = string
  default = "t2.micro"
}
variable "backend_server_size" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type    = string
  default = "zantac_inc_key"
}
variable "public_key_path" {
  type    = string
  default = "/root/.ssh/id_rsa.pub"
}
variable "private_key_path" {
  type    = string
  default = "/root/.ssh/id_rsa"
}
variable "ssh_user_name" {
  type    = string
  default = "ec2-user"
}
variable "ssh_time_out" {
  type    = string
  default = "1m"
}
