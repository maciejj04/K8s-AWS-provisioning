#!/bin/bash

. ../bash_utils.sh

dns_zone="mj-developement.com"
cloud="aws"
cloud_labels="Owner=Jozefczyk_Maciej,Email=maciejj04@gmail.com"
k8s_version=1.11.2

for i in "$@"
do
case $i in
    -z=*|--zones=*)
    zones="${i#*=}"
    shift # past argument=value
    ;;

    -c=*|--node-count=*)
    node_count="${i#*=}"
    shift # past argument=value
    ;;

    -s=*|--node-size=*)
    node_size="${i#*=}"
    shift # past argument=value
    ;;

    -S=*|--master-size=*)
    master_size="${i#*=}"
    shift # past argument=value
    ;;

    -C=*|--master-count=*)
    master_count="${i#*=}"
    shift # past argument=value
    ;;

    -N=*|--name=*)
    name="${i#*=}"
    shift # past argument=value
    ;;

    -t=*|--state-store=*)
    kops_state_store="${i#*=}"
    shift # past argument=value
    ;;

    *)
          echo "UNKNOWN OPTION FOR SCRIPT $0; EXITING..."
          exit 1
    ;;

esac
done

name=$name.$dns_zone

printf "
        node_count: $node_count \n
        zones: $zones \n
        node_size: $node_size \n
        master_size: $master_size \n
        name: $name\n"

echo "Creating cluster configuration..."

set -x 
kops create cluster \
      --kubernetes-version $k8s_version
      --cloud $cloud \
      --state $kops_state_store \
      --node-count $node_count \
      --zones $zones \
      --dns-zone $dns_zone \
      --node-size $node_size \
      --master-count $master_count \
      --master-size $master_size \
      --cloud-labels "$cloud_labels" \
      --name $name
      --log_dir logs
      # --master-zones $master_zones \
      # --node-security-groups sg-12345678 \
      # --master-security-groups sg-12345678,i-abcd1234 \
      # --topology private \
      # --networking weave \
      # --master-public-name string            Sets the public master public name

set +x;
while true; do
    read -p "Proceed with cluster creation? [y/n]: " decision

    if [ $decision == "y" ]; then
            kops update cluster ${name} --yes
            break
    elif [ $decision == "n" ]; then
            echo -e "
                To edit cluster configuration before creating cluster:\n$ kops edit cluster ${name}
                To manually create cluster from provided configuration please use:\n$ kops update cluster ${name} --yes"
            break
    else
        echo "Wrong value provided... try again."
    fi
done

#TODO: ensure clustter was created
echo -e "To validate cluster plesae use:\n $ kops validate cluster --name ${name}"