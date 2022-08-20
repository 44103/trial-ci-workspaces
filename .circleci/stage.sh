#!/bin/sh

switch_tf_workspace() {
  terraform workspace new $1
  terraform workspace select $1
  # TODO: exec failed
  # circleci-agent step halt
}

init_tf_workspace() {
  terraform init -reconfigure -backend-config=dev.tfbackend
  terraform fmt -check
  terraform validate
  switch_tf_workspace $1
  terraform plan
}

cd infrastructure/service

echo $DEV_TFBACKEND | base64 -d >dev.tfbackend

WORKSPACE=$CIRCLE_BRANCH
if [[ $CIRCLE_BRANCH =~ feature ]]; then
  WORKSPACE=${CIRCLE_BRANCH/feature\//ft}
fi

init_tf_workspace $WORKSPACE
terraform apply -auto-approve
