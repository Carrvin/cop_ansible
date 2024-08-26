output "lb_instance_dns" {
  value = aws_route53_record.cop_ansible_lb_dns.name
}

output "app_green_env_instances_dns" {
  value = aws_route53_record.cop_ansible_app_green_env_dns[*].name
}

output "app_blue_env_instances_dns" {
  value = aws_route53_record.cop_ansible_app_blue_env_dns[*].name
}
