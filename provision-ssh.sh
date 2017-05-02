#!/bin/bash

# create users
# https://www.howtoforge.com/user_password_creating_with_a_bash_script

# setup language
sudo -u vagrant locale-gen UTF-8
# Setup passphraseless SSH.
sudo -u vagrant ssh-keygen -t rsa -P '' -f /home/vagrant/.ssh/id_rsa
sudo -u vagrant cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
sudo -u vagrant chmod 0600 /home/vagrant/.ssh/authorized_keys
sudo -u vagrant cp /vagrant/files/ssh_config /home/vagrant/.ssh/config
sudo -u vagrant chmod 0600 /home/vagrant/.ssh/config
# rm -rf /vagrant/ssh_keys/*
cp -r -u '/home/vagrant/.ssh/.' /vagrant/ssh_keys/ssh-$HOSTNAME/
cp -u '/etc/hosts' /vagrant/ssh_keys/ssh-$HOSTNAME/
 # :inline => "cp /home/vagrant/.ssh /vagrant/ssh_keys/"
# Create a cache folder under /vagrant, which mounts the host filesystem.
# This means we won't have to re-download large binaries (e.g. Hadoop 2.7 is 202 MB)
# when running vagrant up after a vagrant destroy. Note that we rely on the 'continue'
# option of wget and HTTP server support for this to work.
