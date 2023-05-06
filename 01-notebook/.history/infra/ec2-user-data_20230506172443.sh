#!/bin/bash
# This script is injected into the AWS vm on creation
# and can be used to provision your VM
# NB it's run as root, so no need for sudo

# debug logs are here
readonly logName="/var/log/server-setup.log"

echo "Starting $(date)" | sudo tee -a "${logName}"

echo "Install required tools" | sudo tee -a "${logName}"
sudo yum install -y \
    docker \
    iptraf-ng \
    htop \
    tmux \
    vim \
    curl \
    git

# put your own github username here
echo "Setting up ssh access keys" | sudo tee -a "${logName}"
sudo curl -s https://github.com/fin710.keys | sudo tee -a /home/ec2-user/.ssh/authorized_keys


############################################################
## 👇👇👇👇👇 application install commands here 👇👇👇👇👇

echo "installing Nodejs using NVM" | sudo tee -a "${logName}"
sudo curl --silent --location https://rpm.nodesource.com/setup_16.x | bash -
sudo yum -y install nodejs

echo "installing application" | sudo tee -a "${logName}"
(cd /home/ec2-user && sudo git clone https://github.com/EmilijusV/SDS2.git)

echo "installing deps and starting application $(date)" | sudo tee -a "${logName}"
(cd /home/ec2-user/week-16-lab/app && sudo npm install && DEBUG=* PORT=80 npm start)
