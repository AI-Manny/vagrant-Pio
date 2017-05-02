# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

# ---- Configuration variables ----

GUI               = false # Enable/Disable GUI
RAM               = 2048   # Default memory size in MB

# Network configuration
DOMAIN            = ".ml.company.com"
NETWORK           = "192.168.50."
NETMASK           = "255.255.255.0"

BOX               = 'ubuntu/trusty64'

HOSTS = {
   "master" => [NETWORK+"10", RAM, GUI, BOX],
   "slave1" => [NETWORK+"11", RAM, GUI, BOX],
   "slave2" => [NETWORK+"12", RAM, GUI, BOX],
  #  "slave3" => [NETWORK+"13", RAM, GUI, BOX],
}

# ANSIBLE_INVENTORY_DIR = 'ansible/inventory'


Vagrant.configure("2") do |config|
  HOSTS.each do | (name, cfg) |
    ipaddr, ram, gui, box = cfg

    config.vm.define name do |machine|
      machine.vm.box   = box

      machine.vm.provider "virtualbox" do |vbox|
        vbox.gui    = gui
        vbox.memory = ram
        vbox.name = name
      end



      machine.vm.hostname = name + DOMAIN
      machine.vm.network 'private_network', ip: ipaddr, netmask: NETMASK
      # machine.vm.network :forwarded_port, guest: 7070, host: 7070
      # config.vm.network :forwarded_port, guest: 7077, host: 7077
      # config.vm.network :forwarded_port, guest: 8000, host: 8000
      # config.vm.network :forwarded_port, guest: 8080, host: 8080
      # config.vm.network :forwarded_port, guest: 9000, host: 9000
      # config.vm.define "master", primary: true do |machine|

  end



# ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep -v '10.0'
  end# HOSTS-each
  config.vm.provision :shell, :inline => "sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/America/Puerto_Rico /etc/localtime", run: "always"
  config.vm.provision "shell", path: "provision-ssh.sh"
  config.vm.provision "shell", path: "provision.sh"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
end



  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
