resource "aws_vpc" "aws18-vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "aws18-vpc"
    }
}

//--- 서브넷 생성 ---------------------------------
// ap-northeast-2a
resource "aws_subnet" "aws18-public-subnet-2a" {
    vpc_id = aws_vpc.aws18-vpc.id
    cidr_block = var.public_subnet[0]
    availability_zone = var.azs[0]

    tags = {
        Name = "aws18-public-subnet-2a"
    }
}
resource "aws_subnet" "aws18-private-subnet-2a" {
    vpc_id = aws_vpc.aws18-vpc.id
    cidr_block = var.private_subnet[0]
    availability_zone = var.azs[0]

    tags = {
        Name = "aws18-private-subnet-2a"
    }
}

// ap-northeast-2c
resource "aws_subnet" "aws18-public-subnet-2c" {
    vpc_id = aws_vpc.aws18-vpc.id
    cidr_block = var.public_subnet[1]
    availability_zone = var.azs[1]

    tags = {
        Name = "aws18-public-subnet-2c"
    }
}
resource "aws_subnet" "aws18-private-subnet-2c" {
    vpc_id = aws_vpc.aws18-vpc.id
    cidr_block = var.private_subnet[1]
    availability_zone = var.azs[1]

    tags = {
        Name = "aws18-private-subnet-2c"
    }
}

// 인터넷 게이트웨이
resource "aws_internet_gateway" "aws18-igw" {
    vpc_id = aws_vpc.aws18-vpc.id

    tags = {
        Name = "aws18-igw"
    }
}

// EIP
resource "aws_eip" "aws18-eip" {
    domain = "vpc"
    depends_on = [ aws_internet_gateway.aws18-igw ]
    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "aws18-eip"
    }
}

// NAT 게이트웨이
resource "aws_nat_gateway" "aws18-nat" {
    allocation_id = aws_eip.aws18-eip.id
    subnet_id = aws_subnet.aws18-public-subnet-2a.id
    depends_on = [ aws_internet_gateway.aws18-igw ]

    tags = {
        Name = "aws18-nat"
    }
}

// 라우터
# public route table
resource "aws_default_route_table" "aws18-public-rt-table" {
    default_route_table_id = aws_vpc.aws18-vpc.default_route_table_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.aws18-igw.id
    }
    tags = {
        Name = "aws18-public-rt-table"
    }
}

resource "aws_route_table_association" "aws18-public-rt-2a" {
    subnet_id = aws_subnet.aws18-public-subnet-2a.id
    route_table_id = aws_default_route_table.aws18-public-rt-table.id
}

resource "aws_route_table_association" "aws18-public-rt-2c" {
    subnet_id = aws_subnet.aws18-public-subnet-2c.id
    route_table_id = aws_default_route_table.aws18-public-rt-table.id
}

# private route table
resource "aws_route_table" "aws18-private-rt-table" {
    vpc_id = aws_vpc.aws18-vpc.id
    tags = {
        Name = "aws18-private-rt-table"
    }
}

# private route
resource "aws_route" "aws18-private-rt" {
    route_table_id = aws_route_table.aws18-private-rt-table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.aws18-nat.id
}

resource "aws_route_table_association" "aws18-private-rt-2a" {
    subnet_id = aws_subnet.aws18-private-subnet-2a.id
    route_table_id = aws_route_table.aws18-private-rt-table.id
}

resource "aws_route_table_association" "aws18-private-rt-2c" {
    subnet_id = aws_subnet.aws18-private-subnet-2c.id
    route_table_id = aws_route_table.aws18-private-rt-table.id
}