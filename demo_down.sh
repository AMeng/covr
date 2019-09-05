#!/usr/bin/env bash

set -Eeo pipefail

cd terraform
terraform destroy -auto-approve
cd ..

kops delete cluster --yes

cd terraform/bootsrap
terraform destroy -auto-approve
cd ../..
