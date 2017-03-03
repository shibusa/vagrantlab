# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.9.2"
Vagrant.configure("2") do |config|
  config.vm.define "core", primary: true do |core|
    core.vm.box = "centos/7"
    core.vm.hostname = "core"
    core.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.250"
    core.vm.provision :shell, path: "init.sh"
    core.vm.provision :shell, path: "vboxguest.sh"
    core.vm.provision :shell, path: "rubycompile.sh"
    core.vm.provision :shell, path: "chefserver.sh"
  end
  #
  # config.vm.define "nodeone" do |nodeone|
  #   nodeone.vm.box = "centos/7"
  #   nodeone.vm.hostname = "nodeone"
  #   nodeone.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.251"
  #   nodeone.vm.provision :shell, path: "vboxguest.sh"
  # end
  #
  # config.vm.define "nodetwo" do |nodetwo|
  #   nodetwo.vm.box = "centos/7"
  #   nodetwo.vm.hostname = "nodetwo"
  #   nodetwo.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.252"
  #   nodetwo.vm.provision :shell, path: "vboxguest.sh"
  # end
end
