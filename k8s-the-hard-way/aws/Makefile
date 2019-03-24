CF_TEMPL_PATH=file:///home/maciejj/Dokumenty/Clusters/Kubernetes/aws/k8s-the-hard-way/aws/ec2-ubuntu-with-ebs.yaml
STACK_NAME=k8s-master-stack

validate:
	aws cloudformation validate-template --template-body ${CF_TEMPL_PATH}

create:
	aws cloudformation create-stack --template-body ${CF_TEMPL_PATH} --stack-name=${STACK_NAME}

delete:
	aws cloudformation delete-stack --stack-name=${STACK_NAME}

get-stack-public-ips:
	aws ec2 describe-instances --query "Reservations[*].Instances[*].PublicIpAddress" --output=text --filters "Name=tag:aws:cloudformation:stack-name,Values=${STACK_NAME}"