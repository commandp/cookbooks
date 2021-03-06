if node[:notify][:slack][:webhook_url]
execute 'notify slack finished deployed' do
  command "curl -X POST --data-urlencode " +
          "\'payload={" +
          "\"channel\": \"#{node[:notify][:slack][:channel]}\"," +
          "\"username\": \"#{node[:notify][:slack][:username]}\"," +
          "\"text\": \"【#{node[:opsworks][:stack][:name]} : #{node[:opsworks][:instance][:hostname]}】#{node[:notify][:deploy][:finished]}\"," +
          "\"icon_url\": \"#{node[:notify][:slack][:icon_url]}\"}\' " +
          node[:notify][:slack][:webhook_url]
  action :run
end
end