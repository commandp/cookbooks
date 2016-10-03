include_recipe 'zabbix-agent::service'

node[:deploy].each do |application, deploy|
  if node[:zabbix-agent]

    # Install necessary package.
    package 'Install wget' do
      package_name 'wget'
      action :install
    end
    
    # Create directory for 'nginx-check.sh'.
    directory '/etc/zabbix/bin' do
      owner 'root'
      group 'root'
      mode '0755'
      action :create
    end
    
    # Put nginx-check.sh to `/etc/zabbix/bin/`.
    cookbook_file '/etc/zabbix/bin/nginx-check.sh' do
      source: 'zabbix/nginx-check.sh'
      owner 'root'
      group 'root'
      mode 0755
    end
    
    # Put nginx.conf to `/etc/zabbix/zabbix_agentd.conf.d`.
    cookbook_file '/etc/zabbix/zabbix_agentd.conf.d/nginx.conf' do
      source: 'zabbix/zabbix_agentd_nginx.conf'
      owner 'root'
      group 'root'
      mode 0644
    end

    # restart service.
    service "zabbix-agent" do
      supports :restart => true, :reload => true, :status => true
      action :reload
    end

  end
end
