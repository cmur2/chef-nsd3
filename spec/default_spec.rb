require 'chefspec'

describe 'nsd3::default' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'nsd3::default'
  end

  it 'installs nsd3' do
    expect(chef_run).to install_package 'nsd3'
  end
  
  it 'configures nsd' do
    expect(chef_run).to create_file_with_content "/etc/nsd3/nsd.conf", "server:"
  end
  
  it 'enables and starts ietd' do
    expect(chef_run).to start_service "nsd3"
    expect(chef_run).to set_service_to_start_on_boot "nsd3"
  end
end
