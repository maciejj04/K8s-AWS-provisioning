#!/bin/bash

. ../bash_utils.sh

checkArgs $1 $2
id=$(pwgen --no-capitalize 7 1)
echo "Generated random cluster identifier: $id"
#eu-west-2
type=$1
region=$2

set -x; aws s3api create-bucket --bucket mj-k8s-$type-$region-$id-state-store --region $region --create-bucket-configuration LocationConstraint=$region

# Consider S3 versioning
# aws s3api put-bucket-versioning --bucket mj-k8-state-store --versioning-configuration Status=Enabled
