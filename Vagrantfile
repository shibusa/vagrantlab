# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.9.2"
Vagrant.configure("2") do |config|
  # Vagrant ssh private key
  config.ssh.private_key_path = ["~/.ssh/id_rsa", "~/.vagrant.d/insecure_private_key"]
  config.ssh.insert_key = false

  # Chef server
  config.vm.define "core", primary: true do |core|
    core.vm.box = "centos/7"
    core.vm.hostname = "core.shibusa.io"
    core.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.250"
    core.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
    core.vm.provision :shell, path: "init.sh"
    core.vm.provision :shell, path: "vboxguest.sh"
    core.vm.provision :shell, path: "rubycompile.sh"
    core.vm.provision :shell, path: "chefserver.sh"
  end

  # Chef clients
  config.vm.define "nodeone" do |nodeone|
    nodeone.vm.box = "centos/7"
    nodeone.vm.hostname = "nodeone.shibusa.io"
    nodeone.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.251"
    nodeone.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
    nodeone.vm.provision :shell, path: "vboxguest.sh"
  end

  config.vm.define "nodetwo" do |nodetwo|
    nodetwo.vm.box = "centos/7"
    nodetwo.vm.hostname = "nodetwo.shibusa.io"
    nodetwo.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.252"
    nodetwo.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
    nodetwo.vm.provision :shell, path: "vboxguest.sh"
  end
end
