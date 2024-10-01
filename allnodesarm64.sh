  #!/bin/bash

  #run this script file on all the nodes marked for cluster formation.

  sudo apt update -y
  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  sudo apt update -y
  sudo apt install -y kubelet kubeadm kubectl
  sudo apt-mark hold kubelet kubeadm kubectl
  sudo swapoff -a
  sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
  sudo systemctl enable --now kubelet

  ## installing containerd.io

  sudo apt-get update -y 
  sudo apt-get -y install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  # sysctl params required by setup, params persist across reboots

  cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
  net.ipv4.ip_forward = 1
  EOF


  wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/arm64/containerd.io_1.7.22-1_arm64.deb
  wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/arm64/docker-ce-cli_27.3.1-1~ubuntu.22.04~jammy_arm64.deb
  wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/arm64/docker-ce_27.3.1-1~ubuntu.22.04~jammy_arm64.deb
  wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/arm64/docker-compose-plugin_2.6.0~ubuntu-jammy_arm64.deb
  wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/arm64/docker-buildx-plugin_0.17.1-1~ubuntu.22.04~jammy_arm64.deb

  sudo dpkg -i ./containerd.io_1.7.22-1_arm64.deb \
  ./docker-ce_27.3.1-1~ubuntu.22.04~jammy_arm64.deb \
  ./docker-ce-cli_27.3.1-1~ubuntu.22.04~jammy_arm64.deb \
  ./docker-buildx-plugin_0.17.1-1~ubuntu.22.04~jammy_arm64.deb \
  ./docker-compose-plugin_2.6.0~ubuntu-jammy_arm64.deb
  sudo systemctl restart containerd
  containerd config default > /etc/containerd/config.toml
  sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
  # Apply sysctl params without reboot
  sudo sysctl --system


  sudo apt install firewalld -y
  sudo systemctl start firewalld
  sudo systemctl enable firewalld
 
  sudo firewall-cmd --permanent --zone=public --add-port=6443/tcp
  sudo firewall-cmd --permanent --zone=public --add-port=2379-2380/tcp
  sudo firewall-cmd --permanent --zone=public --add-port=10250/tcp
  sudo firewall-cmd --permanent --zone=public --add-port=10251/tcp
  sudo firewall-cmd --permanent --zone=public --add-port=10252/tcp
  sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
  sudo firewall-cmd --permanent --zone=public --add-port=443/tcp
  sudo firewall-cmd --permanent --zone=public --add-service=http
  sudo firewall-cmd --reload
  sudo firewall-cmd --list-all

