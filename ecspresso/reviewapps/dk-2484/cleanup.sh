#!/usr/bin/env bash
set -e -o pipefail
cd $(dirname $0)

find . -name "ecspresso.jsonnet" | xargs -I{} -P10 ecspresso --config={} delete --force --terminate ||:
sleep 10 # wait for ECS Services to be deleted
aws events describe-rule --name dk-2484-harvestjob &&   aws events delete-rule --name dk-2484-harvestjob --force
aws ecs describe-task-definition --task-definition dreamkast-dev-dk-2484-harvestjob &&   aws ecs deregister-task-definition --task-definition dreamkast-dev-dk-2484-harvestjob
aws servicediscovery get-service --id srv-ub3hk6x3rba2ipxb &&   aws servicediscovery delete-service --id srv-ub3hk6x3rba2ipxb
aws servicediscovery get-service --id srv-xavhn56yrqvtpsuv &&   aws servicediscovery delete-service --id srv-xavhn56yrqvtpsuv
aws elbv2 describe-rules --rule-arn arn:aws:elasticloadbalancing:us-west-2:607167088920:listener-rule/app/dreamkast-dev/122c5b4a47b64f9d/bc86e7b2e4bca8f5/9d716d5ec485471f &&   aws elbv2 delete-rule --rule-arn arn:aws:elasticloadbalancing:us-west-2:607167088920:listener-rule/app/dreamkast-dev/122c5b4a47b64f9d/bc86e7b2e4bca8f5/9d716d5ec485471f
aws elbv2 describe-target-groups --target-group-arn arn:aws:elasticloadbalancing:us-west-2:607167088920:targetgroup/dev-dk-2484/4cbb68947da893f3 &&   aws elbv2 delete-target-group --target-group-arn arn:aws:elasticloadbalancing:us-west-2:607167088920:targetgroup/dev-dk-2484/4cbb68947da893f3
:
