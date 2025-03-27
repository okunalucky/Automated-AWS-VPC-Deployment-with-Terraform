<h1>Vpc Configuration Using Terraform</h1>
<h2>Language used: Terraform</h2>

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
<h3>Nat Gateway</h3>
<p>#Nat gateway for public subnet</p>
<code>resource "aws_eip" "ib" {}
resource "aws_nat_gateway" "gw_nat" {
  allocation_id =aws_eip.ib.id
  subnet_id     =aws_subnet.pub_sub.id
 tags = {
    Name = "gw NAT"
  }
  depends_on = [aws_internet_gateway.gw]
}</code>
<p>Note: To ensure proper ordering, it is recommended to add an explicit dependency on the Internet Gateway for the VPC.</p>
<h3>Routable for private subnet</h3>
<p>#Routable for private subnet</p>
<code>resource "aws_route_table" "private_rt" {
  vpc_id =aws_vpc.app_vpc.id
  tags = {
    Name = "PrivateRouteTable"
  }
}</code>
<h3>Route for private subnet</h3>
<p>#Route for private subnet</p>
<code>resource "aws_route" "p" {
  route_table_id            =aws_route_table.private_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id =aws_nat_gateway.gw_nat.id
}</code>
<h3>Association of private route table to private subnet</h3>
<p>##Association of private route table to private subnet</p>
<code>
resource "aws_route_table_association" "b" {
  subnet_id      =aws_subnet.pri_sub.id
  route_table_id =aws_route_table.private_rt.id
}</code>
<h3>Security Group</h3>
<p>#Public Security Group</p>
<code>resource "aws_security_group" "lucky_sg"{
  vpc_id = aws_vpc.app_vpc.id
  name="luckysg"
  description = "Allow SSH, HTTP inbound traffic"
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    
  }
}
</code>
<h3>Private Security Group</h3>
<p>#Private Security Group</p>
<code>resource "aws_security_group" "okuna_sg"{
  vpc_id = aws_vpc.app_vpc.id
  name="okunasg"
  description = "Allow SSH, HTTP inbound traffic"
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}</code>
<h3>Aws instance in public subnet</h3>
<p>#Aws instance in public subnet</p>
<code>resource "aws_instance" "Demo" {
  ami                     = "ami-0f2d00da2aafb6966"
  instance_type           = "t2.micro"
  subnet_id = aws_subnet.pub_sub.id
  security_groups = [aws_security_group.lucky_sg.id]
  tags = {
    name: "App1"
  }
}</code>
<h3>At the terminal level, run the following codes</h3>
  <code>terraform init</code>
  <code>terraform plan</code>
  <code>terraform apply</code>
  <p>terraform init: it initializes the terraform working directory, downloads the necessary provider plugins, and sets up the backend configuration.</p>
  <p>terraform plan: it helps you understand what changes will be made to your infrastructure before applying them</p>
  <p>terraform apply: it applies the changes required to reach the desired state of your infrastructure as defined in your Terraform configuration files.</p>
![Image](https://github.com/user-attachments/assets/1a0007a1-ed2e-40a6-ac4a-e4e92a833e38)
<p>this is what shows on the terminal affecting running the <code>terraform apply</code></p>
<h3>Time to get into the aws console to see the vpc created</h3>
<p>this image shows the vpc was successfully created</p>
![Image](https://github.com/user-attachments/assets/a5349671-1d27-44be-ad7d-6d7643155758)


