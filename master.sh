
# install only on master / controlplane
# init config for cluster creation with public ip of ec2 instance.

sudo kubeadm init --control-plane-endpoint YOUR PUBLIC IP --pod-network-cidr 192.168.0.0/16 --ignore-preflight-errors all


# download and install calico CNI.
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.2/manifests/tigera-operator.yaml
curl https://raw.githubusercontent.com/projectcalico/calico/v3.28.2/manifests/custom-resources.yaml -O
kubectl apply -f custom-resources.yaml
