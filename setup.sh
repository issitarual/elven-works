#!/bin/bash 
sudo apt update && sudo apt install curl ansible unzip -y 
cd /tmp
git clone https://github.com/issitarual/elven-works.git
unzip ansible.zip
cd ansible
sudo ansible-playbook wordpress.yml --extra-vars "wp_db_name=${wordpress_db_name} wp_db_username=${wordpress_db_username} wp_db_password=${wordpress_db_password} wp_db_host=${rds_db_host} rds_db_host=${rds_db_host} rds_db_port=${rds_db_port} rds_db_username=${rds_db_username} rds_db_password=${rds_db_password} session_save_path=''" 