cookbook_file '/etc/logrotate.d/nginx' do
  source 'nginx.conf'
  mode '0644'
end
