#!/bin/sh

switch_tf_workspace() {
  terraform workspace new $1
  terraform workspace select $1
}

cd infrastructure/service

echo $DEV_TFBACKEND | base64 -d >dev.tfbackend

terraform init -reconfigure -backend-config=dev.tfbackend
terraform fmt -check
terraform validate
switch_tf_workspace $1
terraform plan
terraform apply -auto-approve
