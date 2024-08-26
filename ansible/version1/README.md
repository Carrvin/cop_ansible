ansible -i inventory.yml all -m ping
ansible -i inventory.yml all --limit cop1 -a "/bin/echo hello"
ansible -i inventory.yml all -m ansible.builtin.copy -a "src=./data/test1.txt dest=/home/ubuntu/test1.txt"

ansible-playbook -i inventory.yml site.yml --check