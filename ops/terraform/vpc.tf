resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags {
    Name    = "${var.project}"
    Project = "${var.project}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
  tags {
    Name    = "${var.project}-public"
    Project = "${var.project}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
    Name    = "${var.project}-private"
    Project = "${var.project}"
  }
}

resource "aws_subnet" "public" {
  count                   = "${length(split(",", var.availability_zones))}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${format("10.0.%d.0/24", count.index)}"
  availability_zone       = "${element(split(",", var.availability_zones), count.index)}"
  map_public_ip_on_launch = true
  tags {
    Name    = "${var.project}-public-${count.index}"
    Project = "${var.project}"
  }
}

resource "aws_subnet" "private" {
  count                   = "${length(split(",", var.availability_zones))}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${format("10.0.%d.0/24", count.index + 100)}"
  availability_zone       = "${element(split(",", var.availability_zones), count.index)}"
  map_public_ip_on_launch = false
  tags {
    Name    = "${var.project}-private-${count.index}"
    Project = "${var.project}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
    Name    = "${var.project}"
    Project = "${var.project}"
  }
}

resource "aws_route_table_association" "public" {
  count          = "${length(split(",", var.availability_zones))}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  count          = "${length(split(",", var.availability_zones))}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}
