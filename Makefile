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

	ansible-vault decrypt terraform/vault/secret.datadog.auto.tfvars.encrypted \
	    --vault-pass-file ./ansible/.vault_pass.txt \
		--output terraform/secret.datadog.auto.tfvars

tf-init:
	make -C terraform init

tf-apply:
	make -C terraform apply
	cd ansible && ansible-vault encrypt group_vars/*/vault_main.yml --vault-password-file .vault_pass.txt

tf-destroy:
	make -C terraform destroy

ansible-install-requirements:
	make -C ansible install-requirements

ansible-prepare-hosts:
	make -C ansible prepare-hosts

ansible-deploy:
	make -C ansible deploy-app

ansible-install-monitoring:
	make -C ansible install-monitoring
