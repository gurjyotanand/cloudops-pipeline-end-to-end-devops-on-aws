#!/bin/bash
yum update -y
sudo yum install -y ansible
git clone https://github.com/gurjyotanand/cloudops-pipeline-end-to-end-devops-on-aws.git /tmp/cloudops-pipeline-end-to-end-devops-on-aws
ansible-playbook /tmp/cloudops-pipeline-end-to-end-devops-on-aws/ansible/webserver.yml