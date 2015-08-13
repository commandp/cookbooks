
execute 'Installing n' do
  command 'npm cache clean -f && npm install -g n'
  not_if 'which n'
end

execute "Installing Nodejs #{node['node_version']}" do
  command "n #{node['node_version']}"
  not_if "node -v | grep #{node['node_version']}"
end
