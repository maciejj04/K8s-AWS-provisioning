#!/bin/bash

. ../bash_utils.sh

checkArgs 2 $1 $2

function check_bucket_existance() {
  aws s3api list-buckets | jq '.Buckets[].Name' | grep mj-k8s-1mc-1mc-eu-west-2-aechah0-state-storee -q
  if [ $? -eq 0 ]; then
    echo "Bucket already exists... exiting."
    echo -e "In order to delete bucket use: \n$ aws s3api delete-bucket --bucket mj-k8s-1mc-1mc-eu-west-2-aechah0-state-store --region eu-west-2"
    exit 1
  fi
}

suffix=state-store
#eu-west-2
cluster_name=$1 #mj-k8s-$type-$region-$id
region=$2
bucket_name=$cluster_name-$suffix

check_bucket_existance

echo "Creting S3 bucket named: $bucket_name"
set -x; aws s3api create-bucket --bucket $bucket_name --region $region --create-bucket-configuration LocationConstraint=$region; set +x

if [ $? -eq 0 ]; then
  # TODO: replace that with AWS api invocation
  echo "S3 bucket created successfully"
else
  exit 1
fi

export KOPS_STATE_STORE=s3://$bucket_name

# Consider S3 versioning
# aws s3api put-bucket-versioning --bucket mj-k8-state-store --versioning-configuration Status=Enabled
