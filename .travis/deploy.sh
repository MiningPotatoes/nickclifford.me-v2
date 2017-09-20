#!/bin/bash

eval "$(ssh-agent -s)"
chmod 660 .travis/id_rsa
if [ -z 'ssh-keygen -F $IP' ]; then
  ssh-keyscan -H $IP >> ~/.ssh/known_hosts
fi

git config --global push.default matching
git remote add deploy git@$IP:$DEPLOY_DIR
git push deploy master

ssh apps@$IP << EOF
  cd $DEPLOY_DIR
  crystal build --release index.cr
EOF
