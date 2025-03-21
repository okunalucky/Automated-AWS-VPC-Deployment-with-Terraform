### provider block
provider "aws" {
  region = "sa-east-1"
  profile = ""
}



### networking ####
###vpc
resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "app_vpc"  
  }
}

##subnet
##public subnet
resource "aws_subnet" "pub_sub" {
  vpc_id     = aws_vpc.app_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "publicSubnet"
  }
}

##subnet
##private subnet
resource "aws_subnet" "pri_sub" {
  vpc_id     = aws_vpc.app_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "privateSubnet"
  }
}


##IGW

resource "aws_internet_gateway" "gw" {
  vpc_id =aws_vpc.app_vpc.id

  tags = {
    Name = "IGW"
  }
}

##routable
resource "aws_route_table" "public_rt" {
  vpc_id =aws_vpc.app_vpc.id
  tags = {
    Name = "PublicRouteTable"
  }
}

##route for public subnet

resource "aws_route" "r" {
  route_table_id            =aws_route_table.public_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id =aws_internet_gateway.gw.id
  
}

##association of public subnet and public route
resource "aws_route_table_association" "a" {
  subnet_id      =aws_subnet.pub_sub.id
  route_table_id =aws_route_table.public_rt.id 
}

##nat gw for private subnet
resource "aws_eip" "ib" {}
resource "aws_nat_gateway" "gw_nat" {
  allocation_id =aws_eip.ib.id
  subnet_id     =aws_subnet.pub_sub.id
 tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

##Rout table for private subnet
resource "aws_route_table" "private_rt" {
  vpc_id =aws_vpc.app_vpc.id
  tags = {
    Name = "PrivateRouteTable"
  }
}

##route for private subnet
resource "aws_route" "p" {
  route_table_id            =aws_route_table.private_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id =aws_nat_gateway.gw_nat.id
}

##Association of private route table to private subnet
resource "aws_route_table_association" "b" {
  subnet_id      =aws_subnet.pri_sub.id
  route_table_id =aws_route_table.private_rt.id
}

###Security Group
##Public Security Group
resource "aws_security_group" "lucky_sg"{
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



##Private Security Group
resource "aws_security_group" "okuna_sg"{
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
}
##aws instance in public subnet
resource "aws_instance" "Demo" {
  ami                     = "ami-0f2d00da2aafb6966"
  instance_type           = "t2.micro"
  subnet_id = aws_subnet.pub_sub.id
  security_groups = [aws_security_group.lucky_sg.id]
  tags = {
    name: "App1"

  }
}

##aws instance in private subnet
# resource "aws_instance" "Demo1" {
#   ami                     = "ami-0f2d00da2aafb6966"
#   instance_type           = "t2.micro"
#   subnet_id = aws_subnet.pri_sub.id
#   security_groups = [aws_security_group.sg_ssh]
#   tags = {
#     name: "App2"

#   }
# }