#
# Cookbook Name:: commandp
# Recipe:: configs
#
# Copyright 2015, Jimmy Kuo
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]
  Chef::Log.info("create database.yml")
  template "#{deploy[:deploy_to]}/shared/config/database.yml" do
    source "database.yml.erb"
    mode 0755
    group deploy[:group]
    owner deploy[:user]
    variables(
      "database" => node['deploy']['commandp_production_ready']['database']
    )
  end
end
