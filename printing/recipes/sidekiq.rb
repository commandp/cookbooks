#
# Cookbook Name:: commandp
# Recipe:: sidekiq
#
# Copyright 2012, Jimmy Kuo
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, deploy|
  if node[:sidekiq]
    template "#{deploy[:deploy_to]}/shared/config/sidekiq.yml" do
      source "sidekiq.yml.erb"
      mode 0755
      group deploy[:group]
      owner deploy[:user]
      variables(
        "sidekiq" => node[:sidekiq]
      )
    end
  end
end
