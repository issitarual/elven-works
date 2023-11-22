# Wordpress Turbinado
### Description
Create a server using WordPress on AWS in an automated way and perform Monitoring or Observability with Cloud Watch.
### Preview
| WordPress      | Clloud Watch       |
| -------------- | -------------- |
| ![Captura de tela 2023-11-22 174538](https://github.com/issitarual/elven-works/assets/81389078/31dd2904-05b8-4101-82dc-59dd089317d0)     | ![Captura de tela 2023-11-22 174646](https://github.com/issitarual/elven-works/assets/81389078/e9015349-e5f2-4768-9e5a-bdd0788a7731)    |

### Requirements
- [x]  Provision resources using Terraform
    - [x]  VPC
    - [x]  EC2
    - [x]  RDS
- [x]  Provision at leats 2 servidores Linux on AWS
- [x]  Install and configure WordPress with Ansible in EC2
- [x]  Configure database in another server (RDS)
- [x]  Create a minimal Monitoring or Observability environment using Cloud Watch
- [x]  Create indicators do CPU, Memory, Disco, and HTTP Request or for the Four Golden Signals (Latency, Traffic, Errors, and Saturation) -> done using Cloud Watch

### Future improvements
- [ ]  Provision resources using Terraform
    - [ ]  *Memcached*
    - [ ]  *EFS*
    - [ ]  *Load Balancer*
- [ ]  *Multizone with high availability architecture*
- [ ]  *Memcached session repository on another server*
- [ ]  *Configure scalable and elastic file storage (EFS)*
- [ ]  *Elastic architecture with VMs and autoscaling*
- [ ]  *Architecture with CDN/WAF*
    - [ ]  *Cloudflare (https://www.cloudflare.com/pt-br/plans/#overview)*
    - [ ]  *Serviço WAF (https://aws.amazon.com/pt/waf/pricing/)*
- [ ]  *Create a minimal Monitoring or Observability environment using Prometheus, Grafana e* 1P
### Technologies
  ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
  ![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
  ![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
  ![WordPress](https://img.shields.io/badge/WordPress-%23117AC9.svg?style=for-the-badge&logo=WordPress&logoColor=white)
### How to run

1. Clone this repository;
2. Open the CLI on the downloaded folder and make sure you are logged in your AWS account;
3. Make the changes on the variables file, for example, change your secret key and access key;
4. Run Terraform
```bash
terraform init
terraform plan
terraform apply
```
4. Finally access your WordPress using the instance IPV4 address.
