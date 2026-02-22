ansible-encrypt-vaults:
	cd ansible && ansible-vault encrypt group_vars/*/vault*.yml --vault-password-file .vault_pass.txt

ansible-decrypt-vaults:
	cd ansible && ansible-vault decrypt group_vars/*/vault*.yml --vault-password-file .vault_pass.txt

ansible-prepare:
	cd ansible && ansible-playbook -i inventory.yml playbook.yml --tags prepare --vault-password-file .vault_pass.txt

ansible-deploy:
	cd ansible && ansible-playbook -i inventory.yml playbook.yml --tags n8n --vault-password-file .vault_pass.txt

tf-apply-only:
	cd terraform && terraform apply -auto-approve

tf-apply: tf-apply-only ansible-encrypt-vaults

tf-destroy:
	cd terraform && terraform destroy -auto-approve
