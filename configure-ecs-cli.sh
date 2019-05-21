#!/bin/bash

set -ex

NAME=${NAME:$(_cloud9_prompt_user)}
AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)

clustername=$(aws cloudformation describe-stacks --stack-name ec2-base-$NAME --query 'Stacks[0].Outputs[?OutputKey==`ClusterName`].OutputValue' --output text)
ecs-cli configure --region $AWS_REGION --cluster $clustername --default-launch-type EC2 --config-name ecs-workshop
