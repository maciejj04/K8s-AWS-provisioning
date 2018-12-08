#!/bin/bash

# TODO: host names!

for i in "$@"
do
case $i in
    --workers-ips=* ) WORKERS_IPS="${i#*=}"; shift ;;
    --masters-ips=* ) MASTERS_IPS="${i#*=}"; shift ;;
    --k8s-public-ip=* ) KUBERNETES_PUBLIC_IP_ADDRESS="${i#*=}"; shift ;;

    *) echo "UNKNOWN OPTION FOR SCRIPT $0; EXITING..."
       exit 1 ;;
esac
done

function usage() {
    echo """Usage:
        --workers-ips       - list (e.g. --workers-ips=10.10.10.1,10.1.10.5)
        --masters-ips       - list
        --k8s-public-ip
    """
}

if [ -z "$WORKERS_IPS" ] || [ -z "$MASTERS_IPS" ] || [ -z "$KUBERNETES_PUBLIC_IP_ADDRESS" ]; then
    usage;
    exit 1;
fi
# TODO: include all master and all slave nodes in json ("master", "worker1")

masters_count=$(echo ${MASTERS_IPS} | tr ',' '\n' | wc -l )
workers_count=$(echo ${WORKERS_IPS} | tr ',' '\n' | wc -l )
# TODO.

# Mapping args to propper Json format list
WORKERS_IPS=$(echo \"$WORKERS_IPS\" | perl -pe 's/,/","/g')
MASTERS_IPS=$(echo \"$MASTERS_IPS\" | perl -pe 's/,/","/g')

echo """
Script args:

WORKERS_IPS:        $WORKERS_IPS
MASTERS_IPS:        $MASTERS_IPS
"""

cat > kubernetes-client-csr.json <<EOF
{
  "CN": "kubernetes-client",
  "hosts": [
    "master",
    "worker1",
    $WORKERS_IPS,
    $MASTERS_IPS,
    "${KUBERNETES_PUBLIC_IP_ADDRESS}",
    "127.0.0.1"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "PL",
      "L": "Krakow",
      "O": "Kubernetes",
      "OU": "Kubernetes",
      "ST": "Malopolska"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  kubernetes-client-csr.json | cfssljson -bare kubernetes-client