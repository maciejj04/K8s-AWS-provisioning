Example usage:

`
ansible-playbook provision_ca_and_gen_tls_cert.yaml -e cluster_size=1mc-1mc
`

See/Validate generated cert:

`
$ openssl x509 -in ca.pem -text -noout
`

## Turn off source destination check on cluster instances (?)
## Turn on br_netfilter kernel module
`sudo modprobe br_netfilter`

and ensure that it's on by:
```
cat /proc/sys/net/bridge/bridge-nf-call-iptables
1
```
### Debugging:

`k apply -f helpers/kube-dns.yaml`

`k apply -f helpers/kubernetes-dashboard.yaml`

`k get svc kubernetes-dashboard -n kube-system -o jsonpath='{.spec.ports[0].nodePort}'`

#### Tools

`k run tiny-tools --image=giantswarm/tiny-tools --command sleep 9999`

```
kubectl run nginx --image=nginx
kubectl expose deployment nginx --port 80 --type NodePort
```

#### Networking

`10.32`

`ip route get 4.2.2.1`

#### Containers

`sudo crictl -r unix:///var/run/containerd/containerd.sock ps`

#### Metrics

- add role to heapster service account

##### Prometheus

###### PV issue

Modify prometheus and alertmanager deployments to use hostPath(may be related to swap problem?)


###### Lack of premissions
```
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```

#### Fake workload

`kubectl run spaster --image=spaster/alpine-sleep`
