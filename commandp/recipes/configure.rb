#
# Cookbook Name:: commandp
# Recipe:: configs
#
# Copyright 2012, Jimmy Kuo
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  directory "#{deploy[:deploy_to]}/shared/config" do
    group deploy[:group]
    owner deploy[:user]
    mode 0775
    action :create
    recursive true
  end

  directory "#{deploy[:deploy_to]}/shared/uploads" do
    group deploy[:group]
    owner deploy[:user]
    mode 0775
    action :create
    recursive true
  end

  directory "#{deploy[:deploy_to]}/shared/print_works" do
    group deploy[:group]
    owner deploy[:user]
    mode 0775
    action :create
    recursive true
  end

  [:application, :skylight, :redis, :paypal].each do |service|
    if node[service]
      template "#{deploy[:deploy_to]}/shared/config/#{service.to_s}.yml" do
        source "service.yml.erb"
        mode 0755
        group deploy[:group]
        owner deploy[:user]
        variables(
          "service" => node[service]
        )
      end
    end
  end

  if node[:sidekiq]
    template "#{deploy[:deploy_to]}/shared/config/sidekiq.yml" do
      source "sidekiq.yml.erb"
      mode 0755
      group deploy[:group]
      owner deploy[:user]
    end
  end

end
