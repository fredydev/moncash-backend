#!/bin/bash

cd functions
mkdir -p nodejs
cd nodejs
npm install https://github.com/ecelestin/ecelestin-Moncash-sdk-nodejs uuid
cd ..
zip -r9 lambda-layer.zip nodejs 
rm -rf nodejs