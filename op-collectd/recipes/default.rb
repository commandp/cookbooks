#
# Cookbook Name:: op-collectd
# Recipe:: default
#
# Copyright (C) 2015 Sammy
#
# All rights reserved - Do Not Redistribute
#

# Enable influxdb plugin
if node[:collectd][:influxdb][:enabled]
template "#{node["collectd"]["dir"]}/etc/conf.d/network.conf" do
  source "collectd_network.conf.erb"
    variables({
       :ipaddress => node[:collectd][:influxdb][:ipaddress],
       :prot => node[:collectd][:influxdb][:prot]
     })
end
end

service "collectd" do
  action :restart
end
