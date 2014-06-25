#
# Cookbook Name:: printing
# Recipe:: configs
#
# Copyright 2012, Jimmy Kuo
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  directory "#{deploy[:deploy_to]}/shared/config" do
    owner "root"
    group "root"
    mode 00644
    action :create
  end

  if node[:settings]
    template "#{deploy[:deploy_to]}/shared/config/application.yml" do
      source "application.yml.erb"
      mode 0755
      group deploy[:group]
      owner deploy[:user]

      settings = Hash[node["settings"]]
      variables(
        "settings" => settings
      )
    end
  end

  if node[:redis]
    template "#{deploy[:deploy_to]}/shared/config/redis.yml" do
      source "redis.yml.erb"
      mode 0755
      group deploy[:group]
      owner deploy[:user]

      redis = Hash[node["redis"]]
      variables(
        "redis" => redis
      )
    end
  end

  if node[:sidekiq]
    template "#{deploy[:deploy_to]}/shared/config/sidekiq.yml" do
      source "sidekiq.yml.erb"
      mode 0755
      group deploy[:group]
      owner deploy[:user]

      variables(
        "rails_env" => node[:deploy][:rails_env],
        "sidekiq" => node[:sidekiq]
      )
    end
  end

  if node[:librato]
    template "#{deploy[:deploy_to]}/shared/config/librato.yml" do
      source "librato.yml.erb"
      mode 0755
      group deploy[:group]
      owner deploy[:user]
      variables(
        "librato" => node[:librato]
      )
    end
  end

  if deploy[:remote_configs]
    deploy[:remote_configs].each do |url|
      basename = File.basename(url)
      remote_file "#{deploy[:deploy_to]}/shared/config/#{basename}" do
        source url
        owner deploy[:user]
        group deploy[:group]
        mode 00644
      end
    end
  end
end
