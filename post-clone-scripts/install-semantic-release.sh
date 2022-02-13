#!/bin/bash

read -rp "Your git username: " GIT_USERNAME
sed -i '' "s+khaosdoctor+$GIT_USERNAME+g" package.json

read -rp "Your repository name: " REPO_NAME
sed -i '' "s+template-node-ts+$REPO_NAME+g" package.json

npx husky install
npx semantic-release-cli setup
