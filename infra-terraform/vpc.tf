resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "intervertest-vpc"
  }
}

# Gateways

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# --- subnets ---

# Create a private subnet to launch our backend instances
resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  #cidr_block              = "{cidrsubnet(aws_vpc.vpc.cidr_block,1 ,1)}"
  cidr_block              = "192.168.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.availability_zones}"
}
