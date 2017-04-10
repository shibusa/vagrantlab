# -*- mode: ruby -*-
# vi: set ft=ruby :

iprange = "192.168.1"
ipstart = 200
chefserver = "core"
domain = "shibusa.io"

Vagrant.require_version ">= 1.9.3"
Vagrant.configure("2") do |config|
  # Vagrant ssh private key
  config.ssh.private_key_path = ["~/.ssh/id_rsa", "~/.vagrant.d/insecure_private_key"]
  config.ssh.insert_key = false

  # Enable for GNS3 lab purposes
  # config.vm.provider "virtualbox" do |vb|
  #     vb.customize ["modifyvm", :id, "--nic2", "generic"]
  # end

  # Chef server
  config.vm.define chefserver, primary: true do |core|
    core.vm.box = "centos/7"
    core.vm.hostname = "#{chefserver}.#{domain}"
    core.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "#{iprange}.#{ipstart}"
    core.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
    core.vm.provision :shell, inline: "if [[ -z $(less /etc/hosts | grep #{iprange}.#{ipstart}) ]]; then echo -e '#{iprange}.#{ipstart}\t#{chefserver}.#{domain}\t#{chefserver}' | tee -a /etc/hosts; fi"
    core.vm.provision :shell, path: "init.sh"
    core.vm.provision :shell, path: "vboxguest.sh"
    core.vm.provision :shell, path: "rubycompile.sh"
    core.vm.provision :shell, path: "chefserver.sh"
    core.vm.provision :shell, path: "chefdownloads.sh"
  end

  # Chef clients
  (1..3).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = "node-#{i}.shibusa.io"
      node.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "#{iprange}.#{ipstart + i}"
      node.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
      node.vm.provision :shell, inline: "if [[ -z $(less /etc/hosts | grep #{iprange}.#{ipstart}) ]]; then echo -e '#{iprange}.#{ipstart}\t#{chefserver}.#{domain}\t#{chefserver}' | tee -a /etc/hosts; fi"
      node.vm.provision :shell, path: "vboxguest.sh"
    end
  end
end
