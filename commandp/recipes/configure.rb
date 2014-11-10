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

  Chef::Log.info("setting public key for user #{params[:name]}")
  template "/home/root/.ssh/authorized_keys" do
    cookbook 'ssh_users'
    source 'authorized_keys.erb'
    owner root
    group 'opsworks'
    variables(public_key: OpsWorks::Escape.escape_double_quotes(deploy[:environment_variables][:root_key]))
    only_if do
      File.exists?("/home/root/.ssh") && !params[:public_key].nil?
    end
  end

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

  template "#{deploy[:deploy_to]}/shared/config/sidekiq.yml" do
    source "sidekiq.yml.erb"
    mode 0755
    group deploy[:group]
    owner deploy[:user]
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

end
