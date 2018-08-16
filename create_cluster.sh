#!/bin/bash

. bash_utils.sh

checkArgs $1 $2

zone=$1
name=$2

#TODO: export required env like KOPS_STATE_STORE etc.

echo 'Creating configuration for cluster named ' $2 ' in zone' $1
set -x 
kops create cluster --zones $zone $name
