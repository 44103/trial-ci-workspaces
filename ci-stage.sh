#!/bin/bash

switch_tf_workspace() {
  terraform workspace new $1
  terraform workspace select $1
}

cd infrastructure/service

terraform init
terraform fmt -check
terraform validate
switch_tf_workspace $1
terraform plan
terraform apply -auto-approve
