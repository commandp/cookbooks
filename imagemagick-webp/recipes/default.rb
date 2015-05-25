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

remote_file "#{Chef::Config[:file_cache_path]}/ImageMagick-#{node['imagemagick']['version']}.tar.gz" do
  source "#{node['imagemagick']['source']}ImageMagick-#{node['imagemagick']['version']}.tar.gz"
  action :create
end

execute "Unzip ImageMagick #{node['imagemagick']['version']}" do
  command "tar xzvf #{Chef::Config[:file_cache_path]}/ImageMagick-#{node['imagemagick']['version']}.tar.gz"
  cwd "#{node['imagemagick']['install_path']}"
  not_if File.directory?("#{Chef::Config[:file_cache_path]}/ImageMagick-#{node['imagemagick']['version']}")
  not_if "which convert"
  not_if "convert -version | grep #{node['imagemagick']['version']}"
end

execute "Configure ImageMagick #{node['imagemagick']['version']}" do
  command "./configure && make && make install"
  cwd "#{node['imagemagick']['install_path']}/ImageMagick-#{node['imagemagick']['version']}"
  not_if "which convert"
  not_if "convert -version | grep #{node['imagemagick']['version']}"
end

execute "ldconfig /usr/local/lib"
