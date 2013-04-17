
begin
  include_recipe "logrotate"

  log = "/var/log/nsd.log"
  log = node['nsd3']['server']['logfile'] if not node['nsd3']['server']['logfile'].nil?

  logrotate_app "nsd3" do
    cookbook "logrotate"
    path log
    options ["missingok", "compress", "copytruncate"]
    frequency "weekly"
    create "600 root root"
    rotate 4
  end
rescue
  Chef::Log.error "nsd3::logrotate requires the logrotate cookbook!"
end
