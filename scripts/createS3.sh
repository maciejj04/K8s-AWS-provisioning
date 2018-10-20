#!/bin/bash

. ../bash_utils.sh

checkArgs 2 $1 $2

#eu-west-2
cluster_name=$1 #mj-k8s-$type-$region-$id
region=$2

echo "Creting S3 bucket $cluster_name-state-store"
set -x; aws s3api create-bucket --bucket $cluster_name-state-store --region $region --create-bucket-configuration LocationConstraint=$region

# Consider S3 versioning
# aws s3api put-bucket-versioning --bucket mj-k8-state-store --versioning-configuration Status=Enabled
