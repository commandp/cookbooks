#
# Cookbook Name:: sidekiq
# Recipe:: default
#

node[:deploy].each do |application, deploy|
  application[:sidekiq].each do |worker, options|
    # Convert attribute classes to plain old ruby objects
    config = options[:config] ? options[:config].to_hash : {}
    config.each do |k, v|
      case v
      when Chef::Node::ImmutableArray
        config[k] = v.to_a
      when Chef::Node::ImmutableMash
        config[k] = v.to_hash
      end
    end

    # Generate YAML string
    yaml = YAML::dump(config)

    # Convert YAML string keys to symbol keys for sidekiq while preserving
    # indentation. (queues: to :queues:)
    yaml = yaml.gsub(/^(\s*)([^:][^\s]*):/,'\1:\2:')

    (options[:process_count] || 1).times do |n|
      file "#{deploy[:deploy_to]}/shared/config/sidekiq_#{worker}#{n+1}.yml" do
        mode 0644
        action :create
        content yaml
      end
    end
  end

  template "#{node[:monit][:conf_dir]}/sidekiq_#{application}.monitrc" do
    owner 'root'
    group 'root'
    mode 0644
    source "monitrc.conf.erb"
    variables({
      deploy: deploy,
      application: application,
      workers: workers
    })
  end

  execute "ensure-sidekiq-is-setup-with-monit" do
    command %Q{
      monit reload
    }
  end

  execute "restart-sidekiq" do
    command %Q{
      echo "sleep 20 && monit -g sidekiq_#{application} restart all" | at now
    }
  end
end
