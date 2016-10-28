# ============================================================
#  Author: Jonny / jonny.lai (at) commandp.com
#  Filename: zabbix_monitoring_nginx.rb
#  Modified: 2016-10-03 19:05
#  Description: Deploy nginx status module of Zabbix.
#  Reference: 
#
#   1. Zabbix 监控 nginx 性能 (113) | 运维生存时间
#     - http://www.ttlsa.com/zabbix/zabbix-monitor-nginx-performance/
#
# =========================================================== 

# use the Third-party cookbook.
include_recipe 'zabbix-agent'

# Custom.
log 'custom zabbix-agent environment.'

# - Delete file.
file '/etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf' do
  action :delete
end

# - Delete directorys.
['/etc/zabbix/zabbix_agentd.d', '/etc/zabbix/scripts'].each do |dir|
  directory dir do
    action :delete
  end
end

# - Create directory.
directory '/etc/zabbix/zabbix_agentd.conf.d' do
  action :create
end

# include other recipe.
include_recipe 'commandp::zabbix_agent_memory_usage'

