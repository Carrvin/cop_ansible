resource "aws_security_group" "cop_ansible" {
  name = "cop-ansible"

  vpc_id = aws_vpc.cop_ansible.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "cop_ansible" {
  key_name   = local.key_pair_name
  public_key = file("${path.module}/../ssh/rsa_cop.pub")
}

resource "aws_instance" "cop_ansible_lb" {
  ami                    = local.instance_ami
  instance_type          = local.instance_type
  key_name               = local.key_pair_name
  vpc_security_group_ids = ["${aws_security_group.cop_ansible.id}"]
  subnet_id              = aws_subnet.cop_ansible.id
}

resource "aws_instance" "cop_ansible_app_green_env" {
  count                  = 2
  ami                    = local.instance_ami
  instance_type          = local.instance_type
  key_name               = local.key_pair_name
  vpc_security_group_ids = ["${aws_security_group.cop_ansible.id}"]
  subnet_id              = aws_subnet.cop_ansible.id
}

resource "aws_instance" "cop_ansible_app_blue_env" {
  count                  = 2
  ami                    = local.instance_ami
  instance_type          = local.instance_type
  key_name               = local.key_pair_name
  vpc_security_group_ids = ["${aws_security_group.cop_ansible.id}"]
  subnet_id              = aws_subnet.cop_ansible.id
}
