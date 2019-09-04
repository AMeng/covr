.PHONY: test
SHELL := bash

kops_up:
	@ ./docker.sh ./kops.sh

kops_down:
	@ ./docker.sh bash -c "kops delete cluster --yes"

terraform_up:
	@ ./docker.sh bash -c "cd terraform && terraform init && terraform apply -auto-approve"

terraform_down:
	@ ./docker.sh bash -c "cd terraform && terraform init && terraform destroy -auto-approve"

kubectl_up:
	./docker.sh kubectl apply -f kubernetes

kubectl_down:
	./docker.sh kubectl delete -f kubernetes

format:
	@ ./docker.sh bash -c "cd terraform && terraform fmt"

test:
	@ ./docker.sh ./test/grpcc.sh

validate:
	@ ./docker.sh bash -c "cd terraform && terraform fmt -write=false -check=true -diff=true"
