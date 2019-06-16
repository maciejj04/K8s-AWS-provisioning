K8S_PUBLIC_HOST := $(shell aws elbv2 describe-load-balancers --name "mj-dev-k8s-master-frontend-lb" --query "LoadBalancers[].DNSName" --output=text)
MASTER_IPS := $(shell cd aws/ && make gmspi | tr '\n' ',' | cut -d',' -f1-2 && cd ..) #35.177.106.149,35.178.145.222
MASTER_1_IP := $(shell cd aws/ && make gmspi | tr '\n' ',' | cut -d',' -f1 && cd ..)

setup-masters:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-master-nodes.yaml -i inventory.yaml \
	    -e ansible_python_interpreter=/usr/bin/python3 \
	    -e master_ips=${MASTER_IPS} \
	    -e k8s_public_host=$(K8S_PUBLIC_HOST)

setup-masters-test:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-master-nodes.yaml -i inventory.yaml \
	    -e ansible_python_interpreter=/usr/bin/python3 \
	    -e master_ips=${MASTER_IPS} \
	    -e k8s_public_host=$(K8S_PUBLIC_HOST) --tags "test"

restart-masters:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-master-nodes.yaml -i inventory.yaml \
	    -e ansible_python_interpreter=/usr/bin/python3 \
	    -e master_ips=${MASTER_IPS} \
	    -e k8s_public_host=$(K8S_PUBLIC_HOST) --tags "restart_components"

provision-ca:
	ansible-playbook ./ca_tls/provision_ca_and_gen_tls_cert.yaml -i inventory.yaml \
	    -e k8s_public_host=$(K8S_PUBLIC_HOST) \
	    -e masters_ips=${MASTER_IPS}

setup-control-plane:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-master-nodes.yaml -i inventory.yaml --tags control-plane \
	    -e ansible_python_interpreter=/usr/bin/python3 \
        -e master_ips=${MASTER_IPS}

setup-workers:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-worker-nodes.yaml -i inventory.yaml \
	    -e ansible_python_interpreter=/usr/bin/python3 \
	    -e masters_frontend_lb=$(K8S_PUBLIC_HOST) # --tags "restart_components"

setup-workers-test:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-worker-nodes.yaml -i inventory.yaml \
	    -e ansible_python_interpreter=/usr/bin/python3 --tags "test,mock" \
	    -e masters_frontend_lb=$(K8S_PUBLIC_HOST)

restart-workers:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-worker-nodes.yaml -i inventory.yaml \
	    -e ansible_python_interpreter=/usr/bin/python3 --tags "restart_components" \
	    -e masters_frontend_lb=$(K8S_PUBLIC_HOST)

pnr:
	ansible-playbook --private-key=/home/maciejj/Dokumenty/Clusters/Kubernetes/aws/secrets/k8s-operations.pem setup-worker-nodes.yaml -i inventory.yaml \
		-e ansible_python_interpreter=/usr/bin/python3 --tags "pnr" \
		-e masters_frontend_lb=$(K8S_PUBLIC_HOST)


setup_kubectl:
	ansible-playbook helpers/setup-local-kubectl.yaml -e k8s_frontend_dns=$(K8S_PUBLIC_HOST)

build-from-scratch: provision-ca setup-masters setup-workers

ssh-to-master:
	ssh -i ../secrets/k8s-operations.pem ubuntu@${MASTER_1_IP}

stm: ssh-to-master