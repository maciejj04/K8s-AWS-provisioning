K8S_PUBLIC_HOST=35.178.41.142

install-micro-cluster:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem -i inventory.yaml install-k8s-cluster.yaml -e cluster_size=1mc-1mc -e cluster_size=1mc-1mc -e ansible_python_interpreter=/usr/bin/python3 # -vvvv

setup-masters:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-master-nodes.yaml -i inventory.yaml \
	    -e ansible_python_interpreter=/usr/bin/python3 \
	    -e master_ips=18.130.245.180,35.178.41.142 \
	    -e k8s_public_host=${K8S_PUBLIC_HOST}

provision-ca:
	ansible-playbook ./ca_tls/provision_ca_and_gen_tls_cert.yaml -i inventory.yaml \
	    -e k8s_public_host=${K8S_PUBLIC_HOST} \
	    -e workers_internal_ips=172.31.25.169,172.31.22.84

setup-control-plane:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-master-nodes.yaml -i inventory.yaml --tags control-plane \
	    -e ansible_python_interpreter=/usr/bin/python3 \
        -e master_ips=18.130.119.47,18.130.189.150

setup-workers:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-worker-nodes.yaml -i inventory.yaml \
	    -e ansible_python_interpreter=/usr/bin/python3

setup-workers-test:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-worker-nodes.yaml -i inventory.yaml \
	    -e ansible_python_interpreter=/usr/bin/python3 --tags "test,mock"