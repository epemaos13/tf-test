resource "aws_vpc" "project05-vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "project05-vpc"
  }
}

//--- 서브넷 생성 --------------------
// ap-northeast-2a
resource "aws_subnet" "project05-public1-ap-northeast-2a" {
  vpc_id            = aws_vpc.project05-vpc.id
  cidr_block        = var.public_subnet[0]
  availability_zone = var.azs[0]

  tags = {
    Name = "project05-public1-ap-northeast-2a"
  }
}
resource "aws_subnet" "project05-private1-ap-northeast-2a" {
  vpc_id            = aws_vpc.project05-vpc.id
  cidr_block        = var.private_subnet[0]
  availability_zone = var.azs[0]

  tags = {
    Name = "project05-private1-ap-northeast-2a"
  }
}

// ap-northeast-2c
resource "aws_subnet" "project05-public2-ap-northeast-2c" {
  vpc_id            = aws_vpc.project05-vpc.id
  cidr_block        = var.public_subnet[1]
  availability_zone = var.azs[1]

  tags = {
    Name = "project05-public2-ap-northeast-2c"
  }
}
resource "aws_subnet" "project05-private2-ap-northeast-2c" {
  vpc_id            = aws_vpc.project05-vpc.id
  cidr_block        = var.private_subnet[1]
  availability_zone = var.azs[1]

  tags = {
    Name = "project05-private2-ap-northeast-2c"
  }
}

// 인터넷 게이트웨이
resource "aws_internet_gateway" "project05-igw" {
  vpc_id = aws_vpc.project05-vpc.id

  tags = {
    Name = "project05-igw"
  }
}

// EIP
resource "aws_eip" "project05-eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.project05-igw]
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "project05-eip"
  }
}

// NAT 게이트웨이
resource "aws_nat_gateway" "project05-nat-public1-ap-northeast-2a" {
  allocation_id = aws_eip.project05-eip.id
  subnet_id     = aws_subnet.project05-public1-ap-northeast-2a.id
  depends_on    = [aws_internet_gateway.project05-igw]

  tags = {
    Name = "project05-nat-public1-ap-northeast-2a"
  }
}

// 라우터
# public route table
resource "aws_default_route_table" "project05-public-rt-table" {
  default_route_table_id = aws_vpc.project05-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project05-igw.id
  }
  tags = {
    Name = "project05-public-rt-table"
  }
}

resource "aws_route_table_association" "project05-public1-rt-2a" {
  subnet_id      = aws_subnet.project05-public1-ap-northeast-2a.id
  route_table_id = aws_default_route_table.project05-public-rt-table.id
}

resource "aws_route_table_association" "project05-public2-rt-2c" {
  subnet_id      = aws_subnet.project05-public2-ap-northeast-2c.id
  route_table_id = aws_default_route_table.project05-public-rt-table.id
}

# private route table
resource "aws_route_table" "project05-private-rt-table" {
  vpc_id = aws_vpc.project05-vpc.id
  tags = {
    Name = "project05-private-rt-table"
  }
}

# private route
resource "aws_route" "project05-private-rt" {
  route_table_id         = aws_route_table.project05-private-rt-table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.project05-nat-public1-ap-northeast-2a.id
}

resource "aws_route_table_association" "project05-private1-rt-2a" {
  subnet_id      = aws_subnet.project05-private1-ap-northeast-2a.id
  route_table_id = aws_route_table.project05-private-rt-table.id
}

resource "aws_route_table_association" "project05-private2-rt-2c" {
  subnet_id      = aws_subnet.project05-private2-ap-northeast-2c.id
  route_table_id = aws_route_table.project05-private-rt-table.id
}