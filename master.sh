
# install only on master / controlplane
# init config for cluster creation with public ip of ec2 instance.


sudo kubeadm init --control-plane-endpoint 152.67.22.143 --pod-network-cidr 192.168.0.0/16 --ignore-preflight-errors all

# Download and install calico CNI. Apply the custom-resources.yaml, ONLY if your pod network range is 192.168.0.0/16. 
# If you have selected a different range, you need to change the range in custom-resources.yaml and then apply.
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.2/manifests/tigera-operator.yaml
kubectl apply -f custom-resources.yaml
