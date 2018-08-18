#!/bin/bash

. ../bash_utils.sh

checkArgs 1 $1

kops delete cluster --name $1.mj-developement.com --state s3://$1 --yes