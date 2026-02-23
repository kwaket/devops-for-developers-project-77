decrypt-tf-secrets:
	ansible-vault decrypt terraform/vault/secret.backend.tfvars.encrypted \
	    --vault-pass-file ./ansible/.vault_pass.txt \
		--output terraform/secret.backend.tfvars

	ansible-vault decrypt terraform/vault/secret.n8n.auto.tfvars.encrypted \
	    --vault-pass-file ./ansible/.vault_pass.txt \
		--output terraform/secret.n8n.auto.tfvars

	ansible-vault decrypt terraform/vault/secret.ssh.auto.tfvars.encrypted \
	    --vault-pass-file ./ansible/.vault_pass.txt \
		--output terraform/secret.ssh.auto.tfvars

	ansible-vault decrypt terraform/vault/secret.yc.auto.tfvars.encrypted \
	    --vault-pass-file ./ansible/.vault_pass.txt \
		--output terraform/secret.yc.auto.tfvars

tf-apply-only:
	cd terraform && terraform apply -auto-approve

tf-apply: tf-apply-only ansible-encrypt-vaults

tf-destroy:
	cd terraform && terraform destroy -auto-approve
