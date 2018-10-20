#!/bin/bash

echo "[WARNING] Note that this is not HA!"

type="1mc-1mc"
region="eu-west-2"
domain="mj-developement.com"
cluster_id=$(pwgen --no-capitalize 7 1)
echo "Generated random cluster identifier: $cluster_id"
cluster_name="mj-k8s-$type-$region-$cluster_id"


#TODO: Check prerequisites 

# ################################ VALIDATIONS & local + infra prerequisities #################
# Check wether cluster (cluster specification) already exists along with prerequisite resources: IAM and S3 bucket.
# Check IAM for kops
#./install_kops.sh
#./install_kubectl.sh
# TODO: install_aws_cli.sh

#./createIAM.sh 1mc-1mc eu-west-2
# !!!!!!!!!!!!!!!!   aws ec2 describe-availability-zones --region us-west-2

# #####################################################################################



# ############################### Run cluster prerequisities ##################################
source ./configure_aws_cli.sh
source ./createS3.sh $cluster_name $region

# #####################################################################################


echo "Provisioning $type cluster in $region..."
source ./prepare_local_env_vars.sh $cluster_name

echo "Creating cluster configuration for name: $NAME with state backup in: $KOPS_STATE_STORE"
./create_cluster_configuration.sh -z=eu-west-2a -c=1 -s=t2.micro -S=t2.micro -C=1 -N=$cluster_name --state-store=$KOPS_STATE_STORE

if [ $? -eq 0 ]; then
  echo "Ok"
fi