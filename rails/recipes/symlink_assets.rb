node[:deploy].each do |application, deploy|
  Chef::Log.info("Ensuring shared/assets directory for #{application} app...")

  directory "#{deploy[:deploy_to]}/shared/assets" do
    group deploy[:group]
    owner deploy[:user]
    mode 0775
    action :create
    recursive true
  end
end
