install-micro-cluster:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem -i inventory.yaml install-k8s-cluster.yaml -e cluster_size=1mc-1mc -e cluster_size=1mc-1mc -e ansible_python_interpreter=/usr/bin/python3 # -vvvv

setup-masters:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-master-nodes.yaml -i inventory.yaml \
	    -e ansible_python_interpreter=/usr/bin/python3 \
	    -e etcd_download_url=https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz \
	    -e master_ips=18.130.119.47,18.130.189.150 \
	    -e masters_internal_ips=10.0.0.187,10.0.1.161 \
	    -e k8s_public_host=18.130.119.47 \
        -e etcd_download_url="https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz" \
        -e kube_apiserver_download_url="https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-apiserver" \
        -e kube_controller_manager_download_url="https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-controller-manager" \
        -e kube_scheduler_download_url="https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-scheduler" \
        -e kubectl_download_url="https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kubectl" \
        -e cluster-cidr=10.200.0.0/16 \
        -e service_cluster_ip_range=10.32.0.0/24

provision-ca:
	ansible-playbook ./ca_tls/provision_ca_and_gen_tls_cert.yaml -i inventory.yaml \
	    -e k8s_public_host=1.1.1.1 \
	    -e workers_internal_ips=172.31.25.169,172.31.22.84 \
	    -e masters_internal_ips=10.0.0.187,10.0.1.161

setup-control-plane:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-master-nodes.yaml -i inventory.yaml --tags control-plane -e ansible_python_interpreter=/usr/bin/python3 \
    -e etcd_download_url="https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz" \
	-e kube_apiserver_download_url="https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-apiserver" \
    -e kube_controller_manager_download_url="https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-controller-manager" \
    -e kube_scheduler_download_url="https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-scheduler" \
    -e kubectl_download_url="https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kubectl" \
    -e master_ips=18.130.119.47,18.130.189.150 -e masters_internal_ips=10.0.0.187,10.0.1.161