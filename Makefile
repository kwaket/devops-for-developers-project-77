tf-secrets:
	make -C ansible terraform-secrets

tf-init:
	make -C terraform init

tf-apply:
	make -C terraform apply

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

ansible-encrypt-vault:
	make -C ansible encrypt-vaults

ansible-decrypt-vault:
	make -C ansible decrypt-vaults
