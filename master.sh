
# install only on master / controlplane
# init config for cluster creation with public ip of ec2 instance.
kubeadm init --control-plane-endpoint 13.202.18.177 --pod-network-cidr 192.168.0.0/16

# download and install calico CNI.
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.2/manifests/tigera-operator.yaml
curl https://raw.githubusercontent.com/projectcalico/calico/v3.28.2/manifests/custom-resources.yaml -O
kubectl apply -f custom-resources.yaml
