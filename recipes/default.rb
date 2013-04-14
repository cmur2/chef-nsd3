
package "nsd3"

# first rebuild then restart the service
execute "nsd-restart" do
  command "nsdc rebuild"
  action :nothing
  notifies :restart, "service[nsd3]"
end

file "/etc/nsd3/nsd.conf" do
    content node.generate_nsd3_conf
    owner "root"
    group "root"
    mode 00644
    notifies :run, "execute[nsd-restart]"
end

service "nsd3" do
  supports :status => true, :restart => true
  action [:enable, :start]
end
