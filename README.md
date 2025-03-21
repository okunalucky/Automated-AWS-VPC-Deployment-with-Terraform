<h1>Vpc Configuration Using Terraform</h1>
<h2>First step is to configure the provider block</h2>
<p>### provider block</p>
<code>provider "aws" {
  region = "sa-east-1"
  profile = ""
}</code>
<h2>Networking</h2>
<p>#vpc</p>
<code>resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "app_vpc"  
  }
}</code>
<h3>subnet</h3>
<p>#public subnet</p>
<code>resource "aws_subnet" "pub_sub" {
  vpc_id     = aws_vpc.app_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "sa-east-1a"
  tags = {
    Name = "publicSubnet"
  }
}</code>
<h3>private subnet</h3>
<p>#private subnet</p>
<code>
resource "aws_subnet" "pri_sub" {
  vpc_id     = aws_vpc.app_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "sa-east-1a"
  tags = {
    Name = "privateSubnet"
  }
}
</code>
<h3>Internet Gateway</h3>
<p>#IGW</p>
<code>resource "aws_internet_gateway" "gw" {
  vpc_id =aws_vpc.app_vpc.id
tags = {
    Name = "IGW"
  }
}</code>
<h3>Routable</h3>
<p>#routable</p>
<code>resource "aws_route_table" "public_rt" {
  vpc_id =aws_vpc.app_vpc.id
  tags = {
    Name = "PublicRouteTable"
  }
}</code>
<h3>Route for public subnet</h3>
<p>#route for public subnet</p>
<code>resource "aws_route" "r" {
  route_table_id            =aws_route_table.public_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id =aws_internet_gateway.gw.id
  }
</code>
<h3>Association of public subnet and public route</h3>
<p>#Association of public subnet and public route</p>
<code>resource "aws_route_table_association" "a" {
  subnet_id      =aws_subnet.pub_sub.id
  route_table_id =aws_route_table.public_rt.id 
}</code>
