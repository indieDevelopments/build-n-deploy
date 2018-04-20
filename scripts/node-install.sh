#!/bin/bash

read -p " Which version of Node do you need to install (any valid version): " VERSIONNAME
read -p " Are you using a 32-bit or 64-bit operating system ? Enter 64 or 32: " ARCHVALUE
if [[ $ARCHVALUE = 32 ]]
    then
    printf " using $VERSIONNAME x86 \n"
    ARCHVALUE=86
    URL=http://nodejs.org/dist/v${VERSIONNAME}/node-v${VERSIONNAME}-linux-x${ARCHVALUE}.tar.xz

elif [[ $ARCHVALUE = 64 ]]
    then
    printf " using $VERSIONNAME x64 \n"
    ARCHVALUE=64
    URL=http://nodejs.org/dist/v${VERSIONNAME}/node-v${VERSIONNAME}-linux-x${ARCHVALUE}.tar.xz

else
    printf "invalid input expected either 32 or 64 as input, quitting ... \n"
    exit
fi

# if tar can\'t untar .xz
apt-get update && apt-get install -y \
    curl \
    xz-utils \
    < "/dev/null";

cd ~ && mkdir .node && cd .node;
curl -sL $URL | tar --strip-components 1 -xJ;

if ! grep -q "~/.node/bin" ~/.bashrc; then
  echo "export PATH=$PATH:~/.node/bin" >> ~/.bashrc;
fi;
