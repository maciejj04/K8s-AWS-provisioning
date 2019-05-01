#!/usr/bin/env bash

# TODO: Rewrite this script to ansible

for i in "$@"
do
case $i in
    --name=* ) ETCD_NAME="${i#*=}"; shift ;;
    --index=* ) INDEX="${i#*=}"; shift ;;
    --internal-ip=* ) INTERNAL_IP="${i#*=}"; shift ;;
    --etcd-hosts-ips=* ) ETCD_HOSTS_IPS="${i#*=}"; shift ;;

    *) echo "UNKNOWN OPTION FOR SCRIPT '$i'; EXITING..."
       exit 1 ;;
esac
done

function mapIpsToArgFormat() {
    IFS=',' read -r -a hosts <<< "$1"

    count=${#hosts[@]}
    if [ ${count} =  "0" ]; then
        echo "No peer hosts given"
        return
    fi
    echo "Found ${count} hosts"

    argLine+="etcd${INDEX}=https://${INTERNAL_IP}:2380"

    for (( i=0, idx=0; i<${count}; i++, idx++ ));
    do
        host=${hosts[i]}

        if [ ${idx} = ${INDEX} ]; then
            idx=$(( idx + 1 ))
        fi

        argLine+=",etcd${idx}=https://${host}:2380"
    done
}

mapIpsToArgFormat $ETCD_HOSTS_IPS

cat > etcd.service << EOF
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
ExecStart=/usr/local/bin/etcd --name ${ETCD_NAME} \
--cert-file=/etc/etcd/kubernetes-client.pem \
--key-file=/etc/etcd/kubernetes-client-key.pem \
--peer-cert-file=/etc/etcd/kubernetes-client.pem \
--peer-key-file=/etc/etcd/kubernetes-client-key.pem \
--trusted-ca-file=/etc/etcd/ca.pem \
--peer-trusted-ca-file=/etc/etcd/ca.pem \
--initial-advertise-peer-urls https://${INTERNAL_IP}:2380 \
--listen-peer-urls https://${INTERNAL_IP}:2380 \
--listen-client-urls https://${INTERNAL_IP}:2379,http://127.0.0.1:2379 \
--advertise-client-urls https://${INTERNAL_IP}:2379 \
--initial-cluster-token etcd-cluster-0 \
--initial-cluster ${argLine} \
--initial-cluster-state new \
--data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF