if node[:notify][:slack][:webhook_url]
execute 'notify slack start deploy' do
  command "curl -X POST --data-urlencode " +
          "\'payload={" +
          "\"channel\": \"#{node[:notify][:slack][:channel]}\"," +
          "\"username\": \"#{node[:notify][:slack][:username]}\"," +
          "\"text\": \"#{node[:notify][:deploy][:start]}\"," +
          "\"icon_url\": \"#{node[:notify][:slack][:icon_url]}\"}\' " +
          node[:notify][:slack][:webhook_url]
  action :run
end
end
