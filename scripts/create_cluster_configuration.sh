#!/bin/bash

. ../bash_utils.sh

#./create_cluster_configuration.sh -z=eu-west-2a -n=1 -s=t2.micro  -n=1 -S=t2.micro --cloud=aws


for i in "$@"
do
case $i in
    -z=*|--zones=*)
    zones="${i#*=}"
    shift # past argument=value
    ;;

    -n=*|--node-count=*)
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

    -N=*|--name=*)
    name="${i#*=}"
    shift # past argument=value
    ;;

    *)
          echo "UNKNOWN OPTION; EXITING..."
          exit 1
    ;;

esac
done

printf "
        node_count: $node_count \n
        zones: $zones \n
        node_size: $node_size \n
        master_size: $master_size \n
        name: $name\n"

dns_zone="mj-developement.com"

echo "Creating cluster configuration..."
set -x 
# kops create cluster \
#       --cloud aws 
#       --node-count $node_count \
#       --zones $zones \
#       # --master-zones $master_zones \
#       --dns-zone $dns_zone \
#       --node-size $node_size \
#       --master-size $master_size \
#       # --node-security-groups sg-12345678 \
#       # --master-security-groups sg-12345678,i-abcd1234 \
#       # --topology private \
#       # --networking weave \
#       --cloud-labels "Owner=Jozefczyk, Maciej" \
#       $name


    #   --master-public-name string            Sets the public master public name


