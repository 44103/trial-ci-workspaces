#!/bin/sh

switch_tf_workspace() {
  terraform workspace new $1
  terraform workspace select $1
}

cd infrastructure/service

echo $DEV_TFBACKEND | base64 -d >dev.tfbackend

WORKSPACE=$1
COMMIT_MSG=$(git log --format=oneline -n 1 $CIRCLE_SHA1)

if [[ $1 =~ feature ]]; then
  WORKSPACE=${1/feature\//ft}
fi

echo $COMMIT_MSG

terraform init -reconfigure -backend-config=dev.tfbackend
terraform fmt -check
terraform validate
switch_tf_workspace $WORKSPACE
terraform plan
terraform apply -auto-approve
