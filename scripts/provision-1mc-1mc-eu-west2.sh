#!/bin/bash

type="1mc-1mc"
region="eu-west-2"
cluster_id=$(pwgen --no-capitalize 7 1)
echo "Generated random cluster identifier: $cluster_id"
cluster_name="mj-k8s-$type-$region-$cluster_id"


#TODO: Check prerequisites 

# ################################ VALIDATIONS & local + infra prerequisities #################
# Check wether cluster (cluster specification) already exists along with prerequisite resources: IAM and S3 bucket.
# Check IAM for kops
#./install_kops.sh
#./install_kubectl.sh
#./createIAM.sh 1mc-1mc eu-west-2
# #####################################################################################



# ############################### Run prerequisities ##################################
#./createS3.sh

# #####################################################################################

echo "Provisioning $type cluster in $region..."
source ./prepare_local_env_vars.sh $cluster_name
echo "Creating cluster named: $NAME with state backup in: $KOPS_STATE_STORE"