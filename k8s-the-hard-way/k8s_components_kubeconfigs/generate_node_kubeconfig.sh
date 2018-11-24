#!/usr/bin/env bash

for i in "$@"
do
case $i in
    --node-name=* ) NODE_NAME="${i#*=}"; shift ;;
    --k8s-public-ip=* ) MASTERS_IP="${i#*=}"; shift ;;
    --ca-dir=* ) CA_DIR="${i#*=}"; shift ;;

    *) echo "UNKNOWN OPTION FOR SCRIPT $0; EXITING..."
       exit 1 ;;
esac
done

kubectl config set-cluster mj-k8s \
  --certificate-authority=${CA_DIR}/ca.pem \
  --embed-certs=true \
  --server=https://${MASTERS_IP}:6443 \
  --kubeconfig=${NODE_NAME}.kubeconfig

kubectl config set-credentials system:node:${NODE_NAME} \
  --client-certificate=${CA_DIR}/kubernetes-client.pem \
  --client-key=${CA_DIR}/kubernetes-client-key.pem \
  --embed-certs=true \
  --kubeconfig=${NODE_NAME}.kubeconfig

kubectl config set-context default \
  --cluster=mj-k8s \
  --user=system:node:${NODE_NAME} \
  --kubeconfig=${NODE_NAME}.kubeconfig

kubectl config use-context default --kubeconfig=${NODE_NAME}.kubeconfig
