include_recipe 'nginx::service'

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::web application #{application} as it is not an static HTML app")
    next
  end

  file '/etc/nginx/sites-available/default' do
    action :delete
    only_if { ::File.exists?('/etc/nginx/sites-available/default') }
  end

  template "/etc/nginx/sites-available/#{application}" do
    Chef::Log.debug("Generating Nginx site template for #{application.inspect}")

    source 'nodejs_nginx.erb'
    owner 'root'
    group 'root'
    mode 0644
    variables(
      application: application,
      deploy: deploy
    )
  end

  link "/etc/nginx/sites-enabled/#{application}" do
    to "/etc/nginx/sites-available/#{application}"

    if File.exists?("/etc/nginx/sites-enabled/#{application}")
      notifies :reload, "service[nginx]", :delayed
    end
  end
end
