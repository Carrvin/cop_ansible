locals {
  key_pair_name = "cop_ansible_ssh"
  # ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*
  instance_ami  = "ami-0556dfb1a147512ba"
  instance_type = "t3.micro"
  domain_name   = "pwdev.cloud"
}
