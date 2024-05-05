#!/usr/bin/env bash

cd $(dirname $0)
find . -name "ecspresso.yml" | xargs -I{} -P10 ecspresso --config={} delete --force --terminate
sleep 10 # wait for ECS Services to be deleted
aws servicediscovery delete-service --id srv-f7pduvwkh3v4bzmb
aws elbv2 delete-rule --rule-arn arn:aws:elasticloadbalancing:us-west-2:607167088920:listener-rule/app/dreamkast-dev/122c5b4a47b64f9d/bc86e7b2e4bca8f5/678d5b2700079b81
aws elbv2 delete-target-group --target-group-arn arn:aws:elasticloadbalancing:us-west-2:607167088920:targetgroup/dev-weaver-92/3f7edd641e0d4ea3