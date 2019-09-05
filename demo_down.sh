#!/usr/bin/env bash

set -Eeo pipefail

cd terraform
terraform destroy -auto-approve
cd ..

kops delete cluster --yes

cd terraform/bootstrap
terraform destroy -auto-approve
cd ../..
