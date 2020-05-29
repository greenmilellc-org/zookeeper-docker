#!/bin/bash
echo "[Build] Authenticating with ECR"
if grep -lq '\[mfa\]' ~/.aws/credentials; then
  $(aws ecr get-login --region us-east-1 --no-include-email --profile mfa) || { echo 'ECR authentication failed' ; exit 1; }
else
  $(aws ecr get-login --region us-east-1 --no-include-email) || { echo 'ECR authentication failed' ; exit 1; }
fi
docker build -t gm-zookeeper .
docker tag gm-zookeeper:latest 416142281294.dkr.ecr.us-east-1.amazonaws.com/gm-zookeeper:3.6.1
docker push 416142281294.dkr.ecr.us-east-1.amazonaws.com/gm-zookeeper:3.6.1