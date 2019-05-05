#!/bin/bash

# NOTE: Deprecated. Moved to ansible scripts.

INSTANCE_NR=
EXTERNAL_IP=
INTERNAL_IP=

for i in "$@"
do
case $i in
    -n=*|--instance-nr=*)
    INSTANCE_NR="${i#*=}"
    shift
    ;;

    -e=*|--external-ip=*)
    EXTERNAL_IP="${i#*=}"
    shift
    ;;

    -i=*|--internal-ip=*)
    INTERNAL_IP="${i#*=}"
    shift
    ;;

    *)
          echo "UNKNOWN OPTION FOR SCRIPT $0; EXITING..."
          exit 1
    ;;
esac
done

function usage() {
  echo """Usage:
    -n, --instance-nr         - instance record number (1 - nodes_count)
    -i, --internal-ip         - workes/node internal ip
    -w, --external-ip         - workes/node external ip
    """
}
if [ -z "$INSTANCE_NR" ] || [ -z "$EXTERNAL_IP" ] || [ -z "$INTERNAL_IP" ]; then
  usage;
  exit 1
fi

instance=worker-${INSTANCE_NR}

cat > ${instance}-csr.json << EOF
  {
    "CN": "system:node:${instance}",
    "key": {
      "algo": "rsa",
      "size": 2048
    },
    "names": [
      {
        "C": "PL",
        "L": "Krakow",
        "O": "system:nodes",
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
  -hostname=${instance},${EXTERNAL_IP},${INTERNAL_IP} \
  -profile=kubernetes \
  ${instance}-csr.json | cfssljson -bare ${instance}
