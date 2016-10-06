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

# Install necessary package.
package 'Install wget' do
  package_name 'wget'
  action :install
end

# Create directory for 'nginx-check.sh'.
directory '/etc/zabbix/bin' do
  mode '0755'
  action :create
end

# Put nginx-check.sh to `/etc/zabbix/bin/`.
cookbook_file '/etc/zabbix/bin/nginx-check.sh' do
  source 'zabbix/nginx-check.sh'
  mode 0755
end

# Put nginx.conf to `/etc/zabbix/zabbix_agentd.conf.d`.
cookbook_file '/etc/zabbix/zabbix_agentd.conf.d/nginx.conf' do
  source 'zabbix/zabbix_agentd_nginx.conf'
  mode 0644
end

# restart service.
service "zabbix-agent" do
  supports :restart => true, :status => true
  action :restart
end
