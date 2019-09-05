#!/usr/bin/env bash

set -Eeo pipefail

ADDRESS=$(kubectl get service covr-service \
  --output json | jq -r '.status.loadBalancer.ingress[].hostname')

echo "Testing SplitUnary on 9001..."
echo '{"sentence": "This, the best of all sentences."}' | \
  evans test/sentence.proto \
    --call SplitUnary \
    --host $ADDRESS \
    --port 9001

echo "Testing SplitStream on 9001..."
echo '{"sentence": "This, the best of all sentences."}' | \
  evans test/sentence.proto \
    --call SplitStream \
    --host $ADDRESS \
    --port 9001

echo "Testing SplitUnary on 443 (TLS)..."
echo '{"sentence": "This, the best of all sentences."}' | \
  evans test/sentence.proto \
    --cacert covr.crt \
    --call SplitUnary \
    --host $ADDRESS \
    --port 443 \
  --tls

echo "Testing SplitStream on 443 (TLS)..."
echo '{"sentence": "This, the best of all sentences."}' | \
  evans test/sentence.proto \
    --cacert covr.crt \
    --call SplitStream \
    --host $ADDRESS \
    --port 443 \
  --tls
