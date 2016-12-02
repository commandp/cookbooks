# ============================================================
#  Author: Jonny / jonny.lai (at) commandp.com
#  Cookbook Name: commandp
#  Description: Deploy Sidekiq queue module of Zabbix.
#  Filename: zabbix_agent_sidekiq_queue.rb
#  Modified: 2016-12-02 19:89
#  Recipe: commandp::zabbix_agent_sidekiq_queue
#  Reference:
#
#   1.  IT 內部工作 #1374: 使用 Zabbix 監控 Sidekiq 的 Enqueued 數量 | commandp Inc.
#    - https://ticket.commandp.com/issues/1374
#
# ===========================================================

# load commandp::zabbix-agent recipe."
include_recipe 'commandp::zabbix_agent'

# Install necessary package.
log "Install necessary package."
package 'Install redis-tools' do
  package_name 'redis-tools'
  action :install
end

# Create directory for 'nginx-check.sh'.
log "create /etc/zabbix/bin directory."
directory '/etc/zabbix/bin' do
  mode '0755'
  action :create
end

# Put sidekiq-queue.sh to `/etc/zabbix/bin/`.
log "deploy sidekiq-queue.sh."
template '/etc/zabbix/bin/sidekiq-queue.sh' do
	source 'sidekiq-queue.sh.erb'
  mode 0755
	variables(
		# Setting template variable with attribute.
		:redis_host => node['redis']['host']
   )
end

# Put sidekiq.conf to `/etc/zabbix/zabbix_agentd.conf.d`.
log "deploy sidekiq.conf"
cookbook_file '/etc/zabbix/zabbix_agentd.conf.d/sidekiq.conf' do
  source 'zabbix/zabbix_agentd_sidekiq.conf'
  mode 0644
end

# restart service.
log "restart zabbix-agent."
service "zabbix-agent" do
  supports :restart => true, :status => true
  action :restart
end

