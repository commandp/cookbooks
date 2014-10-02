#
# Cookbook Name:: commandp
# Recipe:: configs
#
# Copyright 2014, Jimmy Kuo
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  opsworks_deploy_user do
    deploy_data deploy
  end

end
