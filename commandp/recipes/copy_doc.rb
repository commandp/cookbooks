template "#{node[:nginx][:dir]}/sites-enabled/doc" do
  source 'nginx_doc.erb'
end

