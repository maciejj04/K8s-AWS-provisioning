#!/bin/bash

. ../bash_utils.sh

checkArgs 1 $1

echo "Exporting cluster NAME and KOPS_STATE_STORE as env variables..."
export NAME=$1
export KOPS_STATE_STORE=s3://$1-state-store