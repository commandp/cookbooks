node[:deploy].each do |application, deploy|

  template "#{node[:nginx][:dir]}/sites-enabled/doc" do
    source 'nginx_doc.erb'
    variables(
      'application' => application
    )
  end

end

