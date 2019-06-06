#!/bin/bash
set -e 
set -o pipefail

if ! command -v kubectl > /dev/null; then
  echo "kubectl command not installed"
  exit 1
fi

#delete ns
#for ns in ./*ns.yml
#do 
#  echo -n "Deleting $ns... "
#  kubectl -f $ns delete 
#done

# delete secrets
for gsecret in ./*/*_secret.yml
do
  echo -n "Deleting $gsecret..."
  kubectl -f $gsecret delete
done


#delete ingress
for ing in ./*/*ingress.yml
do
  echo -n "Deleting $ing... "
  kubectl -f $ing delete
done

# delete the services
for svc in ./*/*_svc.yml
do
  echo -n "Deleting $svc... "
  kubectl -f $svc delete
done

# delete the deployments
for dep in ./*/*_dep.yml
do
  echo -n "Deleting $dep... "
  kubectl -f $dep delete
done

#delete pv/pvc
for storage in ./*/*storage.yml
do
  echo -n "deleting $storage... "
  kubectl -f $storage delete
done


# delete gitlab-config
for gitconfig in ./*_config.yml
do
  echo -n "Deleting $gitconfig..."
  kubectl -f $gitconfig delete
done


