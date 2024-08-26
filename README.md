# CoP Ansible

- You need an AWS account and a Route53 hosted zone (domain) for DNS.
- Install the AWS CLI, Terraform and Ansible on your machine.
- Set up your AWS CLI with your account (see https://docs.aws.amazon.com/cli/v1/userguide/cli-chap-configure.html)
- Create a ssh rsa key using `ssh -t rsa -b 4096` with the name `rsa_cop` in the [ssh](./ssh) directory.
- Update the `domain_name` in [terraform/locals.tf](.terraform/locals.tf) and in ansible/files/haproxy.cfg.

- Navigate into the [terraform](./terraform/) directory and run `terraform init && terraform apply` to create the infrastructure resources.
- Navigate into the ansible directory and run `ansible-playbook -i inventory.yml site.yml` to configure the infrastructure.

- To update the version of the blue or green env, update the `app_version` var in the ansible [inventory file](./ansible/inventory.yml) for the specific env.
  - Run `ansible-playbook -i inventory.yml --limit app_servers_(green|blue) site.yml` to apply it.
- To swap the env (green/blue) in the HAProxy, update the line `default_backend cop_app_` in the [haproxy.cfg](./ansible/files/haproxy.cfg).
  - Run `ansible-playbook -i inventory.yml --limit lb_servers site.yml` to apply it.
- To destroy the green or the blue env for as long as one of them is not in use, update the `create_green_env` or `create_blue_env` vars in [terraform/locals.tf](.terraform/locals.tf).
  - Run `terraform apply` to apply it.