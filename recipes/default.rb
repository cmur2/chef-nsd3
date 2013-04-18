
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

node['nsd3']['zones'].each do |zone_name, data|
  cookbook_file "/etc/nsd3/#{data['zonefile']}" do
    source data['zonefile']
    owner "root"
    group "root"
    mode 00644
    cookbook node['nsd3']['file_cookbook'] if node['nsd3']['file_cookbook']
    notifies :run, "execute[nsd-restart]"
  end
end

service "nsd3" do
  supports :status => false, :restart => true
  action [:enable, :start]
end
