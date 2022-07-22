#!/bin/bash

#docker
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker

#kubectl
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
sudo yum install -y kubectl

#k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

#Let user use docker commands without sudo
sudo usermod -aG docker $USER
