#!/usr/bin/env bash
set -e -o pipefail
cd $(dirname $0)

find . -name "ecspresso.jsonnet" | xargs -I{} -P10 ecspresso --config={} delete --force --terminate ||:
sleep 10 # wait for ECS Services to be deleted
aws events delete-rule --name dk-2444-harvestjob ||:
aws ecs deregister-task-definition --task-definition dreamkast-dev-dk-2444-harvestjob ||:
aws servicediscovery get-service --id srv-43ienoiquif5ubk2 &>/dev/null && aws servicediscovery delete-service --id srv-43ienoiquif5ubk2
aws servicediscovery get-service --id srv-h745bcxoc2av5ao7 &>/dev/null && aws servicediscovery delete-service --id srv-h745bcxoc2av5ao7
aws elbv2 describe-rules --rule-arn arn:aws:elasticloadbalancing:us-west-2:607167088920:listener-rule/app/dreamkast-dev/122c5b4a47b64f9d/bc86e7b2e4bca8f5/5a10abee791e7254 &>/dev/null && aws elbv2 delete-rule --rule-arn arn:aws:elasticloadbalancing:us-west-2:607167088920:listener-rule/app/dreamkast-dev/122c5b4a47b64f9d/bc86e7b2e4bca8f5/5a10abee791e7254
aws elbv2 describe-target-groups --target-group-arn arn:aws:elasticloadbalancing:us-west-2:607167088920:targetgroup/dev-dk-2444/4bf405391c8e9d49 &>/dev/null && aws elbv2 delete-target-group --target-group-arn arn:aws:elasticloadbalancing:us-west-2:607167088920:targetgroup/dev-dk-2444/4bf405391c8e9d49
:
