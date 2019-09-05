#!/usr/bin/env bash

# Get a list of GitHub webhook IPs and return the result as JSON
# This is used to whitelist GitHub webhooks in security groups.
#
# Terraform only allows string key/value pairs in the JSON response,
# so we return the IPs as a comma-delimited string.
#
# Example:
# {"ips": "1.2.3.4/22,5.6.7.8/22"}

set -Eeo pipefail

LB_NAME=$(echo $X | cut -d "-" -f 1)
LB_ARN=$(aws elbv2 describe-load-balancers --names $LB_NAME | jq -r '.LoadBalancers[].LoadBalancerArn')
TG_ARN=$(aws elbv2 describe-target-groups --load-balancer-arn $LB_ARN | jq -r '.TargetGroups[].TargetGroupArn')

echo "{\"lb_arn\": \"$LB_ARN\", \"tg_arn\": \"$TG_ARN\"}"
