#!/bin/bash

type="1mc-1mc"
region="eu-west-2"

#TODO: Check prerequisites (may wait for ansible?)

source ./prepare_local_environment.sh 
echo "Creating cluster named: $NAME with state backup in: $KOPS_STATE_STORE"

#./createIAM.sh 1mc-1mc eu-west-2
