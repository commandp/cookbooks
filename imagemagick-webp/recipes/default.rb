directory node['imagemagick']['install_path'] do
  action :create
  recursive true
end

execute "apt-get update -y"

execute "install package necessary for imagemagick" do
  command "apt-get build-dep imagemagick -y"
end

execute "install libwebp-dev devscripts" do
  command "apt-get install libwebp-dev devscripts -y"
end

remote_file "#{Chef::Config[:file_cache_path]}/ImageMagick-#{node['imagemagick']['version']}.tar.xz" do
  source node['imagemagick']['source_url']
  action :create
end

execute "Unzip ImageMagick #{node['imagemagick']['version']}" do
  command "tar xvJf #{Chef::Config[:file_cache_path]}/ImageMagick-#{node['imagemagick']['version']}.tar.xz"
  cwd "#{node['imagemagick']['install_path']}"
  not_if "convert -version | grep #{node['imagemagick']['version']}"
end

execute "Configure ImageMagick #{node['imagemagick']['version']}" do
  command "./configure && make && make install"
  cwd "#{node['imagemagick']['install_path']}/ImageMagick-#{node['imagemagick']['version']}"
  not_if "convert -version | grep #{node['imagemagick']['version']}"
end

execute "ldconfig /usr/local/lib"
