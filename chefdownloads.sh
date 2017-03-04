#/usr/bin/env bash
chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure --accept-license

chef-server-ctl install opscode-push-jobs-server
chef-server-ctl reconfigure
opscode-push-jobs-server-ctl reconfigure

chef-server-ctl install opscode-reporting
chef-server-ctl reconfigure
opscode-reporting-ctl reconfigure
