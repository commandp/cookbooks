include_recipe "sidekiq::service"

node[:deploy].each do |application, deploy|

  execute "stop Rails app #{application}" do
    command "sudo monit stop -g sidekiq_#{application}_group"
  end

end
