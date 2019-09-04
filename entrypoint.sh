#!/usr/bin/env bash

set -Eeo pipefail

AWS_ZONE=$(aws ec2 describe-availability-zones | jq -r '.AvailabilityZones[].ZoneName' | sort | head -n 1)
export AWS_ZONE
export TF_VAR_kops_bucket_name=$KOPS_BUCKET_NAME
export KOPS_STATE_STORE=s3://$KOPS_BUCKET_NAME

"$@"
