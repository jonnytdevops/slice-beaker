#!/usr/bin/env bash

set -e

MODULE=$1
PLATFORM=$2
PLATFORM_TYPE=$3

HTTP_PROXY=http://proxy.ops.puppetlabs.net:3128;export HTTP_PROXY

# install deps needed when using cloud images
if [[ $PLATFORM_TYPE = *"el-"* ]]; then
    sudo yum -y install libxml2-devel libxslt-devel ruby-devel
    sudo yum -y groupinstall "Development Tools"
elif [[ $PLATFORM_TYPE = *"debian-"* ]] || [[ $PLATFORM_TYPE = *"ubuntu-"* ]]; then
    sudo apt-get update
    sudo apt-get install -y libxml2-dev libxslt-dev zlib1g-dev git ruby ruby-dev build-essential
fi

# prepare ssh
echo "" | sudo tee -a /etc/ssh/sshd_config
echo "Match address 127.0.0.1" | sudo tee -a /etc/ssh/sshd_config
echo "    PermitRootLogin without-password" | sudo tee -a /etc/ssh/sshd_config
echo "" | sudo tee -a /etc/ssh/sshd_config
echo "Match address ::1" | sudo tee -a /etc/ssh/sshd_config
echo "    PermitRootLogin without-password" | sudo tee -a /etc/ssh/sshd_config
mkdir -p .ssh
rm -rf ~/.ssh/id_rsa
ssh-keygen -f ~/.ssh/id_rsa -b 2048 -C "beaker key" -P ""
sudo mkdir -p /root/.ssh
sudo rm /root/.ssh/authorized_keys
cat ~/.ssh/id_rsa.pub | sudo tee -a /root/.ssh/authorized_keys
sudo systemctl restart sshd

# prepare gems
cd /vagrant/modules/$MODULE
sudo gem install bundler --no-rdoc --no-ri --verbose
if [[ ! -d .bundled_gems ]]; then
  mkdir .bundled_gems
fi
export GEM_HOME=`pwd`/.bundled_gems
bundle install


# run tests
export BEAKER_setfile=/vagrant/config/$PLATFORM/hosts_file.yml
export BEAKER_debug=yes
bundle exec rake beaker
