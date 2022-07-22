#!/bin/bash

echo "CREATING K3D CLUSTER"
k3d cluster create p3-cluster --k3s-arg "--disable=traefik@server:0"

# echo "WAITING FOR JOBS TO COMPLETE"
# kubectl wait --for=condition=complete jobs --all -n kube-system --timeout=-1s

echo "CREATING NAMESPACES"
kubectl create namespace argocd
kubectl create namespace dev

echo "INSTALLING ARGO CD NO TLS"
# kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -n argocd
kubectl apply -f argoinstall.yaml -n argocd

echo "WAITING FOR ARGO CD DEPLOYMENTS TO BE AVAILABLE"
kubectl wait --for=condition=available deployment --all -n argocd --timeout=-1s

echo "WAITING FOR ARGO CD PODS TO BE READY"
kubectl wait --for=condition=ready pods --all -n argocd --timeout=-1s

echo "CONNECTING TO ARGO CD SERVER"
kubectl port-forward svc/argocd-server -n argocd 8080:80 &
# kubectl apply -f argoingress.yaml -n argocd
# kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# echo "WAITING FOR ARGO CD DEPLOYMENTS TO BE AVAILABLE"
# kubectl wait --for=condition=available deployment --all -n argocd --timeout=-1s

# echo "WAITING FOR ARGO CD PODS TO BE READY"
# kubectl wait --for=condition=ready pod --all -n argocd --timeout=-1s
