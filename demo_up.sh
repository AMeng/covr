#!/usr/bin/env bash

set -Eeo pipefail

cd terraform/bootstrap
terraform init
terraform apply -auto-approve -target=aws_s3_bucket.kops
cd ../..

kops create cluster \
  --cloud aws \
  --kubernetes-version v1.13.10 \
  --master-count 3 \
  --master-size t3.large \
  --master-volume-size 16 \
  --node-count 3 \
  --node-size t3.medium \
  --node-volume-size 16 \
  --networking calico \
  --yes \
  --zones $AWS_ZONE

until kops validate cluster; do
  echo "Waiting 10 seconds before validating cluster again..."
  sleep 10
done

cd terraform
terraform apply -auto-approve
terraform output -json | jq -r '.ca_cert.value' > ../covr.crt
cd ..

until ./test/test.sh; do
  echo "Waiting 10 seconds before validating endpoints again..."
  sleep 10
done
