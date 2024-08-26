resource "aws_vpc" "cop_ansible" {
  cidr_block = "192.168.0.0/24"
}

resource "aws_subnet" "cop_ansible" {
  cidr_block              = cidrsubnet(aws_vpc.cop_ansible.cidr_block, 3, 1)
  vpc_id                  = aws_vpc.cop_ansible.id
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "cop_ansible" {
  vpc_id = aws_vpc.cop_ansible.id
}

resource "aws_route_table" "cop_ansible" {
  vpc_id = aws_vpc.cop_ansible.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cop_ansible.id
  }
}

resource "aws_route_table_association" "cop_ansible" {
  subnet_id      = aws_subnet.cop_ansible.id
  route_table_id = aws_route_table.cop_ansible.id
}
