#!/bin/sh

switch_tf_workspace() {
  terraform workspace new $1
  terraform workspace select $1 || exit 1
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

WORKSPACE=$1
if [[ $1 =~ feature ]]; then
  WORKSPACE=${1/feature\//ft}
fi

init_tf_workspace $WORKSPACE
terraform apply -auto-approve
