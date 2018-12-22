install-micro-cluster:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem -i inventory.yaml install-k8s-cluster.yaml -e cluster_size=1mc-1mc -e cluster_size=1mc-1mc -e ansible_python_interpreter=/usr/bin/python3 # -vvvv

setup-masters:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-master-nodes.yaml -i inventory.yaml -e ansible_python_interpreter=/usr/bin/python3 -e etcd_download_url=https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz -e master_ips=18.130.119.47,18.130.152.19 -e masters_internal_ips=172.31.25.169,172.31.22.84