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
