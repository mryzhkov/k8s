#!/bin/bash
set -e 
set -o pipefail

if ! command -v kubectl > /dev/null; then
  echo "kubectl command not installed"
  exit 1
fi

#create the NS
#for ns in ./*ns.yml
#do
#  echo -n "Creating $ns... "
#  kubectl -f $ns create
#done

# create storage
for storage in ./*/*_storage.yml
do 
  echo -n "Creating $storage... "
  kubectl -f $storage create
done

# create gitlab-config
for gitconfig in ./*_config.yml
do 
  echo -n "Creating $gitconfig..."
  kubectl -f $gitconfig create
done

#create registry secrets
for rsecret in ./*/*secret.yml
do
  echo -n "Creating $rsecret ..."
  kubectl -f $rsecret create
done

# create ingress
for ing in ./*/*ingress.yml
do
  echo -n "Creating $ing..."
  kubectl -f $ing create
done

# create the services
for svc in ./*/*_svc.yml
do
  echo -n "Creating $svc... "
  kubectl -f $svc create
done

# create the deployments
for dep in ./*/*_dep.yml
do
  echo -n "Creating $dep... "
  kubectl -f $dep create
done

# list pod,deployments,svc
echo "Pod:"
kubectl get pod -n gitlab

echo "Deployments:"
kubectl get deployments -n gitlab

echo "Service:"
kubectl get svc -n gitlab
