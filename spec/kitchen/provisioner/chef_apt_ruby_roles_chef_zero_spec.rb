require 'spec_helper'
require 'kitchen/provisioner/chef_apt_ruby_roles_chef_zero'

describe Kitchen::Provisioner::ChefAptRubyRolesChefZero do

  before do
    @provisioner = Kitchen::Provisioner::ChefAptRubyRolesChefZero.new(BogusInstance.new, nil)
    @apt        = @provisioner.instance_variable_get("@apt")
    @ruby_roles = @provisioner.instance_variable_get("@ruby_roles")
    @chef_zero  = @provisioner.instance_variable_get("@chef_zero")
  end

  it "installs chef zero" do
    expect(@chef_zero).to receive(:install_command)
    expect(@ruby_roles).not_to receive(:install_command)
    expect(@apt).not_to receive(:install_command)

    @provisioner.install_command
  end

  it "inits chef zero" do
    expect(@chef_zero).to receive(:init_command)
    expect(@ruby_roles).not_to receive(:init_command)
    expect(@apt).not_to receive(:init_command)

    @provisioner.init_command
  end

  it "creates sandbox for chef zero and converts ruby roles" do
    expect(@chef_zero).to receive(:create_sandbox).and_return("path").ordered
    expect(@ruby_roles).to receive(:roles_path=).with("path/roles").ordered
    expect(@ruby_roles).to receive(:create_sandbox).ordered
    expect(@apt).not_to receive(:create_sandbox)

    @provisioner.create_sandbox
  end

  it "prepares chef zero" do
    expect(@chef_zero).to receive(:prepare_command)
    expect(@ruby_roles).not_to receive(:prepare_command)
    expect(@apt).not_to receive(:prepare_command)

    @provisioner.prepare_command
  end

  it "runs apt, ruby roles, then chef-zero, in that order" do
    expect(@apt).to receive(:run_command).and_return("apt me").ordered
    expect(@chef_zero).to receive(:run_command).and_return("chef me").ordered
    expect(@ruby_roles).not_to receive(:run_command)

    expect(@provisioner.run_command).to eq("apt me && chef me")
  end

  it "cleans up the chef zero sandbox" do
    expect(@chef_zero).to receive(:cleanup_sandbox)
    expect(@ruby_roles).not_to receive(:cleanup_sandbox)
    expect(@apt).not_to receive(:cleanup_sandbox)

    @provisioner.cleanup_sandbox
  end

  it "returns the home path of chef zero" do
    expect(@chef_zero).to receive(:home_path)
    expect(@ruby_roles).not_to receive(:home_path)
    expect(@apt).not_to receive(:home_path)

    @provisioner.home_path
  end
end
