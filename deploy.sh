#!/bin/bash

APIKEY=$1
if [ "$APIKEY" == "" ]
then
  echo "****************************"
  echo "* APIKEY ***must*** be set *"
  echo "*                          *"
  echo "****************************"
  echo ""
  echo "Exiting program."
  exit 1
fi
echo "Deploying with APIKEY set"
ansible-playbook -u root -e APIKEY=$APIKEY -i ansible/hosts ansible/wooliesx.yml
