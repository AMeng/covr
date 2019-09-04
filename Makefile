SHELL := bash

kops_up:
	@ ./docker.sh ./kops.sh

kops_down:
	@ ./docker.sh bash -c "kops delete cluster --yes"

terraform_up:
	@ ./docker.sh bash -c "cd terraform && terraform init && terraform apply -auto-approve"

terraform_down:
	@ ./docker.sh bash -c "cd terraform && terraform init && terraform destroy -auto-approve"

format:
	@ ./docker.sh bash -c "cd terraform && terraform fmt"

validate:
	@ ./docker.sh bash -c "cd terraform && terraform fmt -write=false -check=true -diff=true"
