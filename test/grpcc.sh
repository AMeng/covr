#!/usr/bin/env bash

set -Eeo pipefail

CLIENT_UNARY='client.SplitUnary({ "sentence": "This, the best of all sentences." }, printReply)'
CLIENT_STREAM='client.SplitStream({ "sentence": "This, the best of all sentences." }).on("data", streamReply).on("status", streamReply)'

ADDRESS=$(kubectl get service covr-service \
  --output json | jq -r '.status.loadBalancer.ingress[].hostname')

grpcc \
  --insecure \
  --proto test/sentence.proto \
  --address $ADDRESS:80 \
  --eval "$CLIENT_UNARY"

grpcc \
  --insecure \
  --proto test/sentence.proto \
  --address $ADDRESS:80 \
  --eval "$CLIENT_STREAM"
