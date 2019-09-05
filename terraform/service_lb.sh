#!/usr/bin/env bash

set -Eeo pipefail

LB_NAME=$(echo $1 | cut -d "-" -f 1)
LB_ARN=$(aws elbv2 describe-load-balancers --names $LB_NAME | jq -r '.LoadBalancers[].LoadBalancerArn')
TG_ARN=$(aws elbv2 describe-target-groups --load-balancer-arn $LB_ARN | jq -r '.TargetGroups[].TargetGroupArn')

echo "{\"lb_arn\": \"$LB_ARN\", \"tg_arn\": \"$TG_ARN\"}"
