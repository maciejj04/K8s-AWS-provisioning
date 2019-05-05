#!/usr/bin/env bash

#TODO: Move to ansible scripts

for i in "$@"
do
case $i in
    --component-name=* ) COMPONENT_NAME="${i#*=}"; shift ;;
    --k8s-public-ip=* ) MASTERS_IP="${i#*=}"; shift ;;

    *) echo "UNKNOWN OPTION FOR SCRIPT $0; EXITING..."
       exit 1 ;;
esac
done

{
  kubectl config set-cluster mj-k8s \
    --certificate-authority=../ca_tls/ca.pem \
    --embed-certs=true \
    --server=https://${MASTERS_IP}:6443 \
    --kubeconfig=${COMPONENT_NAME}.kubeconfig

  kubectl config set-credentials system:${COMPONENT_NAME} \
    --client-certificate=../ca_tls/node/${COMPONENT_NAME}.pem \
    --client-key=../ca_tls/node/${COMPONENT_NAME}-key.pem \
    --embed-certs=true \
    --kubeconfig=${COMPONENT_NAME}.kubeconfig#

  kubectl config set-context default \
    --cluster=mj-k8s \
    --user=system:${COMPONENT_NAME} \
    --kubeconfig=${COMPONENT_NAME}.kubeconfig

  kubectl config use-context default --kubeconfig=${COMPONENT_NAME}.kubeconfig
}
