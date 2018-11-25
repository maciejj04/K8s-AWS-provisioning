# K8s-AWS-provisioning

The aim of this repo is to automate provisioning different types (sizes) of K8s clusters placed in AWS for k8s cluster testing purposes.
Provisioning method:
- using [kops](https://github.com/kubernetes/kops) - scripts present in 'scripts' directory. Note that kops is running all necessary AWS infrastructure for You.
- k8s-the-hard-way (IN PROGRESS) - ansible deployment scripts - do not include running AWS infra.


### Kops method prerequisites 

Before usage please ensure that tools You've installed necessary prerequisites (see scripts in ./prerequisites directory).

## Kops usage tips

* list clusters with: kops get cluster
* edit this cluster with: kops edit cluster ${name}
* edit your node instance group: kops edit ig --name=${name} nodes
* edit your master instance group: kops edit ig --name=${name} master-${zone}