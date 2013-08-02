require 'spec_helper'
require 'kitchen/provisioner/apt'

describe Kitchen::Provisioner::Apt do
  class BogusInstance
    def logger
    end
  end

  it "runs aptitude update" do
    provisioner = Kitchen::Provisioner::Apt.new(BogusInstance.new, nil)
    expect(provisioner).to receive(:sudo).with("aptitude update")
    provisioner.run_command
  end
end
