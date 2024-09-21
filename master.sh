
# install only on master / controlplane 
kubeadm init --control-plane-endpoint 13.202.18.177 --pod-network-cidr 192.168.0.0/16 
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.2/manifests/tigera-operator.yaml
curl https://raw.githubusercontent.com/projectcalico/calico/v3.28.2/manifests/custom-resources.yaml -O

#--apiserver-advertise-address 13.202.18.177  --ignore-preflight-errors all
#--apiserver-advertise-address 13.202.18.177  --ignore-preflight-errors all