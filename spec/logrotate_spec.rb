require 'chefspec'

describe 'nsd3::logrotate' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks', 'spec/support/my-cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path, :step_into => ['logrotate_app'])
  end

  let(:chef_run) do
    chef_runner.converge 'nsd3::logrotate'
  end

  it 'creates nsd3 logrotate config' do
    expect(chef_run).to create_file_with_content "/etc/logrotate.d/nsd3", ""
  end
end
