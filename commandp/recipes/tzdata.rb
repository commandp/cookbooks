execute "Reconfigure TZ DATA" do
  command "echo \"Asia/Taipei\" > /etc/timezone"
  command "dpkg-reconfigure -f noninteractive tzdata"
end
