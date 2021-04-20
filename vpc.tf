resource "aws_vpc" "tomyumadv_vpc" {
    tags                 = {Name = "${var.projectname}-vpc"}
    cidr_block           = "10.0.0.0/16"
    instance_tenancy     = "default"
    enable_dns_hostnames = true
}
resource "aws_subnet" "public_subnet01" {
    tags                    = {Name = "${var.projectname}-public_subnet"}
    vpc_id                  = aws_vpc.tomyumadv_vpc.id
    cidr_block              = "10.0.0.0/24"
    map_public_ip_on_launch = true
}
resource "aws_subnet" "private_subnet01" {
    tags        = {Name = "${var.projectname}-private_subnet"}
    vpc_id      = aws_vpc.tomyumadv_vpc.id
    cidr_block  = "10.0.1.0/24"
}
resource "aws_internet_gateway" "tya_igw" {
    tags    = {Name = "${var.projectname}-igw"}
    vpc_id  = aws_vpc.tomyumadv_vpc.id
}
resource "aws_route_table" "publicrtb" {
  vpc_id = aws_vpc.tomyumadv_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tya_igw.id
  }

  tags = {
    Name = "tya-public-rtb"
  }
}
resource "aws_main_route_table_association" "set_mainrtb" {
  vpc_id         = aws_vpc.tomyumadv_vpc.id
  route_table_id = aws_route_table.publicrtb.id
}
resource "aws_route_table" "privatertb" {
  vpc_id = aws_vpc.tomyumadv_vpc.id

  tags = {
    Name = "tya-private-rtb"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.private_subnet01.id
  route_table_id = aws_route_table.privatertb.id
}

resource "aws_security_group" "sg_allow_http" {
  name        = "sg_allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.tomyumadv_vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_my_ip_only"
  }
}