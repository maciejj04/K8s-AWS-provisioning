#!/bin/bash

. ../bash_utils.sh

checkArgs $1 $2
echo $(randomAlphanumericClusterResourceIdentifier)
uid=randomAlphanumericClusterResourceIdentifier
echo $uid
#eu-west-2
type=$1
region=$2
exit 1
aws s3api create-bucket --bucket mj-k8s-$type-$region-$uid-state-store --region $region --create-bucket-configuration LocationConstraint=$region

# Consider S3 versioning
# aws s3api put-bucket-versioning --bucket mj-k8-state-store --versioning-configuration Status=Enabled
