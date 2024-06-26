#!/usr/bin/env bash
set -e -o pipefail
cd $(dirname $0)

find . -name "ecspresso.yml" | xargs -I{} -P10 ecspresso --config={} delete --force --terminate
sleep 10 # wait for ECS Services to be deleted
aws servicediscovery delete-service --id srv-qmzd6zf6q5klotoj
aws servicediscovery delete-service --id srv-eyq5qldm4aqvacef
aws elbv2 delete-rule --rule-arn arn:aws:elasticloadbalancing:us-west-2:607167088920:listener-rule/app/dreamkast-dev/122c5b4a47b64f9d/bc86e7b2e4bca8f5/7940e1374a1af8f2
aws elbv2 delete-target-group --target-group-arn arn:aws:elasticloadbalancing:us-west-2:607167088920:targetgroup/dev-dk-2354/8ec902a34106d6fe
