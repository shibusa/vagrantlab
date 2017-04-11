# Multi host Vagrant/Virtualbox Setup

## Requirements
Vagrant https://www.vagrantup.com/
Virtualbox https://www.virtualbox.org/

These are vagrant clusters I'm using to simulate core services found within a production environment. Each cluster can be found in designated folder.  Vagrant machines (excluding NonGNS3) are used in conjunction with virtual network environment of https://github.com/shibusa/GNS3hierarchical.

## Current design plans
VLAN | ROLE
--- | --- | ---
5 | Network Monitor traffic
100 | Core Infrastructure Devices
200 | Production Servers

### Core Infrastructure Devices
These are mission critical servers such DNS, Central Authentication (LDAP/TACACS+), Monitoring/Logging, etc.

### Web hosts
Prior to playing around with Chef, this will be used to test out NGINX and HTTP servers.

### Chef
Chef Server will reside in VLAN 100 and the Chef Clients will reside in VLAN 200.  Chef Server will act as a central repository for updates for all hosts within the network.  It will also be responsible for pushing cookbooks to the Chef Clients.  The Chef Clients will utilize Docker and operate as a cluster.
