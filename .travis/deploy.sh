#!/bin/bash

eval "$(ssh-agent -s)"
chmod 600 .travis/id_rsa
ssh-add .travis/id_rsa

ssh apps@$IP -p $PORT <<EOF
  cd $DEPLOY_DIR
  git pull
  shards install
  crystal build --release --no-debug index.cr -o index.new
  mv index.new index # Do not trigger "index" file watching until compilation is done
EOF
