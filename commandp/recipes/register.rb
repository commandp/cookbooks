#
# Cookbook Name:: commandp
# Recipe:: register
#
# Copyright 2012, Jimmy Kuo
#
# All rights reserved - Do Not Redistribute
#

include_recipe "aws"

aws_elastic_lb "register with elb" do
  aws_access_key node[:aws][:access_key_id]
  aws_secret_access_key node[:aws][:secret_access_key]
  node[:aws][:elb].each do |elb|
    name elb[:name]
    action :register
  end
end
