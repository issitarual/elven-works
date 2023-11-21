#!/bin/bash
    sudo apt update && sudo apt install ansible curl git nano unzip -y
    cd /tmp

    git clone https://github.com/64J0/bootcamp-sre-elvenworks

    # delete the default values
    rm ./bootcamp-sre-elvenworks/ansible/wordpress-aws/roles/mysql-server/defaults/main.yml

    tee -a ./bootcamp-sre-elvenworks/ansible/wordpress-aws/roles/mysql-server/defaults/main.yml << END
    ---
    rds_db_host: "${rds_db_host}"
    rds_db_port: "${rds_db_port}"
    rds_db_username: "${rds_db_username}"
    rds_db_password: "${rds_db_password}"
    wordpress_db_name: "${wordpress_db_name}"
    wordpress_db_username: "${wordpress_db_username}"
    wordpress_db_password: "${wordpress_db_password}"
    END

    cp ./bootcamp-sre-elvenworks/ansible/wordpress-aws/roles/mysql-server/defaults/main.yml ./bootcamp-sre-elvenworks/ansible/wordpress-aws/roles/wordpress/defaults/main.yml
    sudo ansible-playbook ./bootcamp-sre-elvenworks/ansible/wordpress-aws/wordpress.yml