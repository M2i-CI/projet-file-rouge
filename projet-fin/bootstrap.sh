#!/bin/bash
apt-get update && apt-get upgrade
apt-get install swapspace -y
echo "Installation Python"
apt-get install -y python
echo "Installation d'Ansible..."
apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible
cp /vagrant/ansible/ansible.cfg /etc/ansible/ansible.cfg
echo "Vagrant to sudoers file"
echo "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
