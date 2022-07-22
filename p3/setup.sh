#!/bin/bash

echo -e "\nCREATING K3D CLUSTER"
k3d cluster create p3-cluster --k3s-arg "--disable=traefik@server:0"

echo -e "\nCREATING NAMESPACES"
kubectl create namespace argocd
kubectl create namespace dev

echo -e "\nINSTALLING ARGO CD WITH NO TLS"
kubectl apply -f argoinstall.yaml -n argocd

echo -e "\nWAITING FOR ARGO CD DEPLOYMENTS TO BE AVAILABLE"
kubectl wait --for=condition=available deployment --all -n argocd --timeout=-1s

echo -e "\nWAITING FOR ARGO CD PODS TO BE READY"
kubectl wait --for=condition=ready pods --all -n argocd --timeout=-1s

echo -e "\nARGO CD SERVER PORT FORWARDING"
kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:80 2>&1 > /dev/null &

echo -e "\nSTARTING APP"
kubectl apply -f wil42-playground.yaml -n argocd

echo -e "\nARGO CD PASSWORD, CONNECT AS 'admin'"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
