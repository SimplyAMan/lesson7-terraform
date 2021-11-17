# Create the security group for ec2 server
resource "aws_security_group" "lesson7-sg-ec2" {
  name = "lesson7-sg-ec2"
  description = "Security Group for EC2 Server"
  vpc_id = aws_vpc.lesson7-vpc.id

  ingress {
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lesson7-sg-ec2"
  }
}

# Create an EC2 instance
resource "aws_instance" "lesson7-ec2" {
  ami           = "ami-0a49b025fffbbdac6"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.lesson7-sg-ec2.id}"]
  subnet_id = aws_subnet.lesson7-ec2-subnet.id

  tags = {
    Name = "aws_instance_ec2"
  }
}
