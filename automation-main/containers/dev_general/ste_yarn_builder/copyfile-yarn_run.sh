#!/bin/sh

cd /mnt/docusaurus
yarn install
yarn build
yarn serve
