cookbook_file '/etc/ImageMagick/policy.xml' do
  source 'ImageMagick-policy.xml'
  mode '0644'
end

cookbook_file '/usr/local/etc/ImageMagick-6/policy.xml' do
  source 'ImageMagick-6-policy.xml'
  mode '0644'
end
