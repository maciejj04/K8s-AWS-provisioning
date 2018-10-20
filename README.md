# K8s-AWS-provisioning

The aim of this repo is to automate provisioning different types (sizes) of K8s clusters placed in AWS for testing purposes using [kops](https://github.com/kubernetes/kops).


### Prerequisites 

Before usage please ensure that tools You've installed necessary prerequisites (see scripts in ./prerequisites directory).

## Kops usage tips

* list clusters with: kops get cluster
* edit this cluster with: kops edit cluster ${name}
* edit your node instance group: kops edit ig --name=${name} nodes
* edit your master instance group: kops edit ig --name=${name} master-${zone}