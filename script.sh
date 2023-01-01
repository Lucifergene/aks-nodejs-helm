#!/bin/bash
TAG=$1
NAMESPACE=$2
CHART_NAME=$3
ACR_LOGIN_SERVER=$4
ACR_REGISTRY_NAME=$5
export KUBECONFIG=$HOME/.kube/config
result=$(eval helm ls --namespace $NAMESPACE | grep $CHART_NAME)
if [ $? -ne "0" ]; then
   echo "Installing Helm Chart"
   helm install --namespace $NAMESPACE --create-namespace $CHART_NAME "oci://$ACR_LOGIN_SERVER/$ACR_REGISTRY_NAME" --version $TAG
else
   echo "Upgrading Helm Chart"
   helm upgrade --namespace $NAMESPACE $CHART_NAME "oci://$ACR_LOGIN_SERVER/$ACR_REGISTRY_NAME" --version $TAG
fi