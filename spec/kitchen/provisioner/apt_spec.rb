require 'spec_helper'
require 'kitchen/provisioner/apt'

describe Kitchen::Provisioner::Apt do
  it "runs aptitude update" do
    provisioner = Kitchen::Provisioner::Apt.new
    provisioner.instance = BogusInstance.new
    expect(provisioner).to receive(:sudo).with("aptitude").and_return("aptitude")
    expect(provisioner.run_command).to eq("aptitude update")
  end
end
