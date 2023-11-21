# Wordpress Turbinado TBD

### Ansible
1. Conect to the instance
- Download [key].pem
- In your terminal, with aws downloaded and configured
cp ./[key].pem ~/.ssh/[key].pem
sudo chmod 600 ~/.ssh/[key].pem
ssh -i ~/.ssh/[key].pem ec2-user@[ip]
2. Download Ansible
- In yout terminal, go to root
sudo su -
- Download Ansible
apt update && apt install curl  ansible
- Verify if download was succesful
ansible --version