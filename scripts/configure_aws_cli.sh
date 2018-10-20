#!/bin/bash

# ensure that cli is configured to use kops keys
echo "Checking AWS CLI configuration..."
user_aaci=$(aws configure get aws_access_key_id)
kops_aaci=$(aws iam list-access-keys --user-name kops | jq '.AccessKeyMetadata[0].AccessKeyId')

if [ "$user_aaci" == "$kops_aaci" ]; then 
  echo "AWS CLI configured properly.";
else
  echo "AWS CLI not configured to use kops credentials!";
  exit 1;
fi

# Because "aws configure" doesn't export these vars for kops to use, we export them now
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)