data "aws_route53_zone" "cop_ansible_domain" {
  name = local.domain_name
}

resource "aws_route53_record" "cop_ansible_lb_dns" {
  zone_id = data.aws_route53_zone.cop_ansible_domain.id
  name    = "cop-lb.${local.domain_name}"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.cop_ansible_lb.public_ip]
}

resource "aws_route53_record" "cop_ansible_app_green_env_dns" {
  count   = length(aws_instance.cop_ansible_app_green_env)
  zone_id = data.aws_route53_zone.cop_ansible_domain.id
  name    = "cop-app${count.index + 1}-green.${local.domain_name}"
  type    = "A"
  ttl     = "30"
  records = [
    "${element(aws_instance.cop_ansible_app_green_env.*.public_ip, count.index)}"
  ]
}

resource "aws_route53_record" "cop_ansible_app_blue_env_dns" {
  count   = length(aws_instance.cop_ansible_app_blue_env)
  zone_id = data.aws_route53_zone.cop_ansible_domain.id
  name    = "cop-app${count.index + 1}-blue.${local.domain_name}"
  type    = "A"
  ttl     = "30"
  records = [
    "${element(aws_instance.cop_ansible_app_blue_env.*.public_ip, count.index)}"
  ]
}
