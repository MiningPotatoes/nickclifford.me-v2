#!/bin/bash

eval "$(ssh-agent -s)"
chmod 600 .travis/id_rsa
ssh-add .travis/id_rsa

git config --global push.default matching
git remote add deploy ssh://git@$IP:$PORT$DEPLOY_DIR
git push deploy master

ssh apps@$IP -p $PORT <<EOF
  cd $DEPLOY_DIR
  shards
  crystal build --release --no-debug index.cr -o index.new
  mv index.new index # Do not trigger "index" file watching until compilation is done
EOF
