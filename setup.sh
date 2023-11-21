#!/bin/bash

    sudo apt update && sudo apt install ansible curl git nano unzip -y
    cd /tmp
    git clone https://github.com/issitarual/elven-works.git
    # delete the default values
    rm ./elven-works/ansible/wordpress-challenge/roles/mysql/defaults/main.yml
    tee -a ./elven-works/ansible/wordpress-challenge/roles/mysql/defaults/main.yml << END
    ---
    rds_db_host: "${rds_db_host}"
    rds_db_port: "${rds_db_port}"
    rds_db_username: "${rds_db_username}"
    rds_db_password: "${rds_db_password}"
    wordpress_db_name: "${wordpress_db_name}"
    wordpress_db_username: "${wordpress_db_username}"
    wordpress_db_password: "${wordpress_db_password}"
    END
    cp ./elven-works/ansible/wordpress-challenge/roles/mysql/defaults/main.yml ./elven-works/ansible/wordpress-challenge/roles/wordpress/defaults/main.yml
    sudo ansible-playbook ./elven-works/ansible/wordpress-challenge/wordpress.yml
    EOF