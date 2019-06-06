#!/bin/bash
set -e 
set -o pipefail

if ! command -v kubectl > /dev/null; then
  echo "kubectl command not installed"
  exit 1
fi

# create namespace
for ns in ./ns.yml
do
  echo -n "Creating $ns ... "
  kubectl -f $ns create
done

# create storage
for storage in ./*_storage.yml
do 
  echo -n "Creating $storage... "
  kubectl -f $storage create
done

# create fluentd-configmap
for fconfig in ./*_cfm.yml
do 
  echo -n "Creating $gitconfig..."
  kubectl -f $fconfig create
done


# create ingress
for ing in ./*ingress.yml
do
  echo -n "Creating $ing..."
  kubectl -f $ing create
done

# create the fluentd
for fluentd in ./fluentd.yml
do
  echo -n "Creating $fluentd... "
  kubectl -f $fluentd create
done

# create the es
for es in ./es_statefulset.yml
do
  echo -n "Creating $es... "
  kubectl -f $es create
done


#create the kibana
for kibana in ./kibana.yml
do
  echo -n "Creating $kibana... "
  kubectl -f $kibana create
done
