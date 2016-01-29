script "install_plugin_es_head" do
  interpreter "bash"
  user "root"
  cwd "#{node.elasticsearch[:dir]}/elasticsearch-#{node.elasticsearch[:version]}/bin/"
  code <<-EOH
    plugin -install mobz/elasticsearch-head
    EOH
  not_if { File.exist?("#{node.elasticsearch[:dir]}/elasticsearch-#{node.elasticsearch[:version]}/plugins/head") }
end

script "install_plugin_es_marvel" do
  interpreter "bash"
  user "root"
  cwd "#{node.elasticsearch[:dir]}/elasticsearch-#{node.elasticsearch[:version]}/bin/"
  code <<-EOH
    plugin -install elasticsearch/marvel/latest
    EOH
  not_if { File.exist?("#{node.elasticsearch[:dir]}/elasticsearch-#{node.elasticsearch[:version]}/plugins/marvel") }
end