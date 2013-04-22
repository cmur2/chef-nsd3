
begin
  include_recipe "logrotate"

  log = "/var/log/nsd.log"
  log = node['nsd3']['server']['logfile'] if not node['nsd3']['server']['logfile'] == ''
  
  user = "nsd"
  user = node['nsd3']['server']['username'] if not node['nsd3']['server']['username'] == ''

  logrotate_app "nsd3" do
    cookbook "logrotate"
    path [log]
    options ["missingok", "compress", "copytruncate"]
    frequency "weekly"
    create "644 #{user} #{user}"
    rotate 4
  end
rescue
  Chef::Log.error "nsd3::logrotate requires the logrotate cookbook!"
end
