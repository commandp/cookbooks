# ============================================================
#  Author: Jonny / jonny.lai (at) commandp.com
#  Cookbook Name: cp-zabbix-agent
#  Description: Deploy memory usage module of Zabbix.
#  Filename: memory_usage.rb
#  Modified: 2016-10-24 16:34
#  Recipe: nginx_status
#  Reference:
#
#   1. - Total memory used by Python process? | Stack Overflow
#    - http://stackoverflow.com/a/40173829/686105
#
# ===========================================================

# load commandp::zabbix-agent recipe."
include_recipe 'commandp::zabbix_agent'

# add zabbix user to `www-data` group
group 'www-data' do
  action :modify
  members 'zabbix'
  append true
end

