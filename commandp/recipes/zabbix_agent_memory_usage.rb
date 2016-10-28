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

# Create directory for 'nginx-check.sh'.
directory '/etc/zabbix/bin' do
  mode '0755'
  action :create
end

# Put nginx-check.sh to `/etc/zabbix/bin/`.
cookbook_file '/etc/zabbix/bin/memory-check.sh' do
  source 'zabbix/memory-check.sh'
  mode 0755
end

# Put nginx.conf to `/etc/zabbix/zabbix_agentd.conf.d`.
cookbook_file '/etc/zabbix/zabbix_agentd.conf.d/memory.conf' do
  source 'zabbix/zabbix_agentd_memory.conf'
  mode 0644
end

# restart service.
service "zabbix-agent" do
  supports :restart => true, :status => true
  action :restart
end
