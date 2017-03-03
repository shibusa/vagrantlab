# Multi host Vagrant/Virtualbox Setup

## Requirements
Vagrant https://www.vagrantup.com/
Virtualbox https://www.virtualbox.org/

## Design
All VMs running Centos 7

'Core' host
- standalone chef server
'Node' hosts
- chef clients
- will take part of docker cloud
