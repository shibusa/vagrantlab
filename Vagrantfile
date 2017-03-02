# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.9.2"
Vagrant.configure("2") do |config|
  config.vm.define "chefDK", primary: true do |chefdk|
    chefdk.vm.box = "centos/7"
    chefdk.vm.hostname = "chefDK"
    chefdk.vm.provision :shell, path: "init.sh"
    chefdk.vm.provision :shell, path: "vboxguest.sh"
  end

  # config.vm.define "chefSER" do |chefser|
  #   chefser.vm.box = "centos/7"
  #   chefser.vm.hostname = "chefSER"
  #   chefdk.vm.provision :shell, path: "init.sh"
  # end
  #
  # config.vm.define "chefCLI" do |chefcli|
  #   chefcli.vm.box = "centos/7"
  #   chefcli.vm.hostname = "chefCLI"
  #   chefdk.vm.provision :shell, path: "init.sh"
  # end
end
