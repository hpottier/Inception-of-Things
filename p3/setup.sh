#!/bin/bash

k3d cluster create <cluster name>

kubectl create namespace argocd
kubectl create namespace dev
