default['imagemagick']['version'] = '6.7.7-10'
default['imagemagick']['install_path'] = "/tmp/imagemagick/#{node['imagemagick']['version']}"
default['imagemagick']['source_url'] = "http://www.imagemagick.org/download/releases/ImageMagick-#{node['imagemagick']['version']}.tar.xz"
