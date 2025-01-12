# Zimbra Installation and Configuration Automation

This project automates the deployment and configuration of the Zimbra email server using Terraform, Ansible, and Jenkins, aimed at providing a reliable and efficient multi-server Zimbra installation in a corporate environment.

## Overview

The infrastructure is provisioned using **Terraform**, and the configuration is managed through **Ansible**. The project includes automation for Zimbra installation and configuration, including the necessary servers, roles, and services, as well as a **CI/CD pipeline** to streamline the entire process using **Jenkins**.

## Features

- **Terraform**: Automates the provisioning of the infrastructure. Terraform outputs are used to configure the infrastructure dynamically.
- **Ansible**: Manages the configuration of the servers, installs Zimbra, and sets up its services. The playbooks ensure that the configuration is consistent across all machines.
- **Jenkins CI/CD Pipeline**: Automates the deployment of Zimbra through a fully integrated pipeline. It handles the infrastructure setup (via Terraform) and server configuration (via Ansible), ensuring seamless deployment.
- **Zimbra FOSS 8.8.15**: The Zimbra 8.8.15 FOSS version is installed, with flexibility to install other versions such as the Network Edition (licensed).
- **Monitoring and Testing**: The system includes monitoring for server status and email tests to ensure the configuration works as expected.

## Files

- **terraform_outputs.json**: Contains the output data from Terraform, including details about the provisioned servers.
- **inventory**: Automatically generated by Terraform, it includes all the necessary server information and Zimbra configuration details.
- **ansible.cfg**: Configuration file for Ansible, which defines the structure and settings, including the inventory file name.
- **hosts.j2**: Jinja2 template used for generating the final hosts configuration.
- **playbook.yml**: The primary Ansible playbook, which runs the series of tasks for installing and configuring Zimbra.
- **Jenkinsfile**: Defines the CI/CD pipeline for automating the deployment process using Jenkins.

## Usage

1. **Clone the Repository and set the needed variables for the project**:  
   `git clone <repository-url>`

2. **Initialize Terraform**:  
   `terraform init`

3. **Apply Terraform Configuration**:  
   `terraform apply`

4. **Configure Servers with Ansible**:  
   `ansible-playbook playbook.yml`

5. **Run the Jenkins Pipeline**:  
   Set up Jenkins and link it to the repository to trigger the pipeline automatically or manually.

