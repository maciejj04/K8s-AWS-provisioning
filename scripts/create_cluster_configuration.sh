#!/bin/bash

. ../bash_utils.sh

checkArgs 2 $1 $2


dns_zone="mj-developement.com"

echo "Creating cluster configuration..."
set -x 
kops create cluster \
      --node-count $node_count \
      --zones $zones \
      --master-zones $master_zones \
      --dns-zone $dns_zone \
      --node-size $node_size \
      --master-size $master_size \
      # --node-security-groups sg-12345678 \
      # --master-security-groups sg-12345678,i-abcd1234 \
      # --topology private \
      # --networking weave \
      --cloud-labels "Owner=Jozefczyk, Maciej" \
      $name
