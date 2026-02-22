install-requirements:
	ansible-galaxy collection install -r requirements.yml

encrypt-vault:
	ansible-vault encrypt group_vars/*/vault*.yml --vault-pass-file .vault_pass.txt

decrypt-vault:
	ansible-vault decrypt group_vars/*/vault*.yml --vault-pass-file .vault_pass.txt

prepare-hosts:
	ansible-playbook playbook.yml -i inventory.yml --tags prepare --vault-pass-file .vault_pass.txt

deploy-app:
	ansible-playbook playbook.yml -i inventory.yml --tags n8n --vault-pass-file .vault_pass.txt
