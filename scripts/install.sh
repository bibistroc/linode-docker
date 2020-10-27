#!/bin/sh
set -e

os=$(cat /etc/*-release | grep -ioE '(alpine|centos|ubuntu|debian)' | uniq -i | tr '[:upper:]' '[:lower:]' | head -n1)

case "$os" in
    ubuntu)
        apt-get update
        apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
        apt-key fingerprint 0EBFCD88
        add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        apt-get update
        apt-get install -y docker-ce docker-ce-cli containerd.io
    ;;
    debian)
        apt-get update
        apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
        curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
        apt-key fingerprint 0EBFCD88
        add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
        apt-get update
        apt-get install -y docker-ce docker-ce-cli containerd.io
    ;;
    centos)
        yum install -y yum-utils
        yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        yum install -y docker-ce docker-ce-cli containerd.io
        systemctl enable docker
        systemctl start docker
    ;;
esac