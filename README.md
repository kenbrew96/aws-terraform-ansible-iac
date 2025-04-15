## PROJECT 1: AWS Infrastructure with Terraform & Ansible

### Goal
Provision an EC2 instance with Terraform and configure it with Ansible (e.g., install Nginx).

### 📁 GitHub Directory Structure
```
aws-terraform-ansible-iac/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── provider.tf
│   └── terraform.tfvars
├── ansible/
│   ├── inventory.ini
│   ├── playbook.yml
│   └── ansible.cfg
├── README.md
```

### 📄 `provider.tf`
```hcl
provider "aws" {
  region = var.aws_region
}
```
**Explanation**: Tells Terraform to use AWS and what region to work in.

### 📄 `variables.tf`
```hcl
variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}
```
**Explanation**: These let you define flexible inputs that can change per environment.

### 📄 `terraform.tfvars`
```hcl
aws_region    = "us-east-1"
instance_type = "t2.micro"
```
**Explanation**: This file holds values that override defaults from `variables.tf`.

### 📄 `main.tf`
```hcl
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
  key_name      = "your-key"
  tags = {
    Name = "WebServer"
  }
}
```
**Explanation**: Provisions an EC2 instance using the input variables.

### 📄 `outputs.tf`
```hcl
output "instance_ip" {
  value = aws_instance.web.public_ip
}
```
**Explanation**: Displays public IP after deployment (useful for SSH or testing).

### 📄 `inventory.ini`
```ini
[web]
<EC2_PUBLIC_IP> ansible_ssh_user=ec2-user ansible_ssh_private_key_file=~/.ssh/your-key.pem
```
**Explanation**: Tells Ansible which server(s) to configure and how to SSH into them.

### 📄 `ansible.cfg`
```ini
[defaults]
inventory = ./inventory.ini
host_key_checking = False
```
**Explanation**: Configures Ansible to use your `inventory.ini` file and disables strict host key checking to prevent connection issues during automation.

### 📄 `playbook.yml`
```yaml
- name: Configure Web Server
  hosts: web
  become: yes
  tasks:
    - name: Install Nginx
      yum:
        name: nginx
        state: present
    - name: Start Nginx
      service:
        name: nginx
        state: started
```
**Explanation**: Automates the configuration of the EC2 instance.
