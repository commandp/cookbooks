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

  directory '/etc/nginx/ssl' do
    action :create
  end

  file "/etc/nginx/ssl/#{deploy[:domains].first}.crt" do
    content deploy[:ssl_certificate]
    mode '0600'
    only_if { deploy[:ssl_support] }
  end

  file "/etc/nginx/ssl/#{deploy[:domains].first}.key" do
    content deploy[:ssl_certificate_key]
    mode '0600'
    only_if { deploy[:ssl_support] }
  end

  file "/etc/nginx/ssl/#{deploy[:domains].first}.ca" do
    content deploy[:ssl_certificate_ca]
    mode '0600'
    only_if { deploy[:ssl_support] && deploy[:ssl_certificate_ca] }
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
