require 'chefspec'

describe 'nsd3::default' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks', 'spec/support/my-cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'nsd3::default'
  end

  it 'installs nsd3' do
    expect(chef_run).to install_package 'nsd3'
  end
  
  it 'configures server' do
    expect(chef_run).to create_file_with_content "/etc/nsd3/nsd.conf", "server:"
  end
  
  it 'configures zones' do
    chef_runner.node.set['nsd3']['zones'] = {
      "example.org" => {
        "zonefile" => "example.org.zone"
      }
    }
    chef_run = chef_runner.converge 'nsd3::default'
    expect(chef_run).to create_file_with_content "/etc/nsd3/nsd.conf", "name: example.org"
  end
  
  it 'creates zone files' do
    chef_runner.node.set['nsd3']['zones'] = {
      "example.org" => {
        "zonefile" => "example.org.zone"
      }
    }
    chef_runner.node.set['nsd3']['file_cookbook'] = 'nsd3-files'
    chef_run = chef_runner.converge 'nsd3::default'
    expect(chef_run).to create_file_with_content "/etc/nsd3/example.org.zone", ""
  end
  
  it 'creates no zone file if requested' do
    chef_runner.node.set['nsd3']['zones'] = {
      "example.org" => {
        "zonefile" => "example.org.zone"
      },
      "example.com" => {
        "zonefile" => "example.com.zone",
        "no_copy" => true
      }
    }
    chef_runner.node.set['nsd3']['file_cookbook'] = 'nsd3-files'
    chef_run = chef_runner.converge 'nsd3::default'
    expect(chef_run).to create_file_with_content "/etc/nsd3/example.org.zone", ""
  end
  
  it 'configures keys' do
    chef_runner.node.set['nsd3']['keys'] = {
      "sec_key" => {
        "algorithm" => "hmac-md5",
        "secret" => "\"6KM6qiKfwfEpamEq72HQdA==\""
      }
    }
    chef_run = chef_runner.converge 'nsd3::default'
    expect(chef_run).to create_file_with_content "/etc/nsd3/nsd.conf", "name: sec_key"
  end
  
  it 'enables and starts nsd3' do
    expect(chef_run).to start_service "nsd3"
    expect(chef_run).to set_service_to_start_on_boot "nsd3"
  end
end
