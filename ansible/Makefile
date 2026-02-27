install-requirements:
	ansible-galaxy install -r requirements.yml

encrypt-vaults:
	ansible-vault encrypt group_vars/*/vault*.yml --vault-pass-file .vault_pass.txt

decrypt-vaults:
	ansible-vault decrypt group_vars/*/vault*.yml --vault-pass-file .vault_pass.txt

terraform-secrets:
	ansible-playbook playbook.yml --tags=terraform --vault-password-file .vault_pass.txt

prepare-hosts:
	ansible-playbook playbook.yml -i inventory.yml --tags prepare --vault-pass-file .vault_pass.txt

deploy-app:
	ansible-playbook playbook.yml -i inventory.yml --tags n8n --vault-pass-file .vault_pass.txt

install-monitoring:
	ansible-playbook playbook.yml -i inventory.yml --tags monitoring --vault-pass-file .vault_pass.txt
