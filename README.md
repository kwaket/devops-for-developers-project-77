### Hexlet tests and linter status:
[![Actions Status](https://github.com/kwaket/devops-for-developers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/kwaket/devops-for-developers-project-77/actions) 
![Upmon](https://app.upmon.com/badge/7a0e9df5-dee6-4526-9d90-512f86/p2Nux392-2.svg)

# n8n infrastructure deploy
Deploy n8n infrastructure using Terraform and Ansible.
Link to the deployed app: [n8n.savangard.space](https://n8n.savangard.space)

## Requirements
- Terraform >= 1.14
- Ansible >= 2.20
- Make

## Deployment

### Prepare project
1. Clone the repository
  ```
  git clone https://github.com/kwaket/devops-for-developers-project-77.git
  ```
2. Decrypt terraform secrets
  ```
  make decrypt-tf-secrets
  ```
3. Initialize terraform
  ```
  make tf-init
  ```
4. Install ansible requirements  
  ```
  make install-ansible-requirements
  ``` 

### Deploy project
1. Deploy infrastructure
  ```
  make tf-apply
  ```
2. Deploy n8n
  ```
  make ansible-prepare-hosts
  make ansible deploy
  ```
3. Install Datadog monitoring
  ```
  make ansible-install-monitoring:
  ```
