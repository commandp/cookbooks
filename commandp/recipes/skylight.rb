#
# Cookbook Name:: commandp
# Recipe:: redis
#
# Copyright 2014, Jimmy Kuo
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, deploy|
  if node[:skylight]
    template "#{deploy[:deploy_to]}/shared/config/skylight.yml" do
      source "skylight.yml.erb"
      mode 0755
      group deploy[:group]
      owner deploy[:user]
      variables(
        "skylight" => node[:skylight]
      )
    end
  end
end

