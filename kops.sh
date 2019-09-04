#!/usr/bin/env bash

set -Eeo pipefail

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
  echo "Waiting 10 seconds before trying again..."
  sleep 10
done
