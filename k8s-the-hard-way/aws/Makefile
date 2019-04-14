CF_MASTER_TEMPL_PATH=file:///home/maciejj/Dokumenty/Clusters/Kubernetes/aws/k8s-the-hard-way/aws/ec2-ubuntu-with-ebs.yaml
CF_WORKER_TEMPL_PATH=file:///home/maciejj/Dokumenty/Clusters/Kubernetes/aws/k8s-the-hard-way/aws/ec2-ubuntu-with-ebs-workers.yaml
MASTER_STACK_NAME=k8s-master-stack
WORKER_STACK_NAME=k8s-worker-stack

validatem:
	aws cloudformation validate-template --template-body ${CF_MASTER_TEMPL_PATH}

create-m:
	aws cloudformation create-stack --template-body ${CF_MASTER_TEMPL_PATH} --stack-name=${MASTER_STACK_NAME}

delete-m:
	aws cloudformation delete-stack --stack-name=${MASTER_STACK_NAME}

get-mstack-public-ips:
	aws ec2 describe-instances --query "Reservations[*].Instances[*].PublicIpAddress" --output=text --filters "Name=tag:aws:cloudformation:stack-name,Values=${MASTER_STACK_NAME}"

gmspi: get-mstack-public-ips

#==========================================================

validatew:
	aws cloudformation validate-template --template-body ${CF_WORKER_TEMPL_PATH}

create-w:
	aws cloudformation create-stack --template-body ${CF_WORKER_TEMPL_PATH} --stack-name=${WORKER_STACK_NAME}

delete-w:
	aws cloudformation delete-stack --stack-name=${WORKER_STACK_NAME}

get-wstack-public-ips:
	aws ec2 describe-instances --query "Reservations[*].Instances[*].PublicIpAddress" --output=text --filters "Name=tag:aws:cloudformation:stack-name,Values=${WORKER_STACK_NAME}"

gwspi: get-wstack-public-ips

