#
# Cookbook Name:: commandp
# Recipe:: redis
#
# Copyright 2012, Jimmy Kuo
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, deploy|
  if node[:paypal]
    template "#{deploy[:deploy_to]}/shared/config/paypal.yml" do
      source "paypal.yml.erb"
      mode 0755
      group deploy[:group]
      owner deploy[:user]
      variables(
        "paypal" => node[:paypal]
      )
    end
  end
end
