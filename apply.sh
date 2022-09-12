#!/bin/bash
set -xe

terraform init
terraform fmt 
terraform validate 
terraform plan -out plan 
terraform apply plan 
