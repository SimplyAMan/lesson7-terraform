resource "aws_vpc" "lesson7-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    "Name" = "lesson7-vpc"
  }
}

resource "aws_subnet" "lesson7-ec2-subnet" {
  vpc_id                  = aws_vpc.lesson7-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    "Name" = "lesson7-ec2-subnet"
  }
}

resource "aws_subnet" "lesson7-rds-subnet1" {
  vpc_id                  = aws_vpc.lesson7-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1b"

  tags = {
    "Name" = "lesson7-rds-subnet1"
  }
}

resource "aws_subnet" "lesson7-rds-subnet2" {
  vpc_id                  = aws_vpc.lesson7-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1c"

  tags = {
    "Name" = "lesson7-rds-subnet1"
  }
}

resource "aws_db_subnet_group" "lesson7-rds-subnet-group" {
  name       = "rds subnet group"
  subnet_ids = ["${aws_subnet.lesson7-rds-subnet1.id}", "${aws_subnet.lesson7-rds-subnet2.id}"]

  tags = {
    "Name" = "lesson7-rds-subnet-group"
  }
}

resource "aws_internet_gateway" "lesson7-igw" {
    vpc_id = aws_vpc.lesson7-vpc.id

    tags = {
      "Name" = "lesson7-igw"
    }
}

resource "aws_route_table" "lesson7-public-crt" {
    vpc_id = aws_vpc.lesson7-vpc.id
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.lesson7-igw.id
    }
    
    tags = {
        Name = "lesson7-public-crt"
    }
}