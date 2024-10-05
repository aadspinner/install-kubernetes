
# install only on master / controlplane
# init config for cluster creation with public ip of ec2 instance.

sudo kubeadm init --control-plane-endpoint 152.67.1.96 --pod-network-cidr 192.168.0.0/16 --ignore-preflight-errors all
sudo kubeadm init --control-plane-endpoint 141.148.219.15 --pod-network-cidr 192.168.0.0/16 --ignore-preflight-errors all

# Download and install calico CNI. Apply the custom-resources.yaml, ONLY if your pod network range is 192.168.0.0/16. 
# If you have selected a different range, you need to change the range in custom-resources.yaml and then apply.
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.2/manifests/tigera-operator.yaml
curl https://raw.githubusercontent.com/projectcalico/calico/v3.28.2/manifests/custom-resources.yaml -O
kubectl apply -f custom-resources.yaml

kubeadm join 152.67.1.96:6443 --token 8nrgxz.k56f5snifxainr2m \
        --discovery-token-ca-cert-hash sha256:e312aec7b7634db76679987bc90730144529a96fe0b9dd76e6aa1aedad6045f9 \
        --control-plane

        kubeadm token create
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'

sudo kubeadm join kubeadm join 144.24.113.182:6443 --token ug1o2q.cmsei526bxiw803o \
    --discovery-token-ca-cert-hash sha256:7ec294a246533954524d4b59c648e046a29e6f47fdba18d9213daa2e8a7cf386 \
    --control-plane --certificate-key 152ea2f95e7cddfcc15f016ab2a963ff2054b7efa994e27db82293dc4ce8668e
    
