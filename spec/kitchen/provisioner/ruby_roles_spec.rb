require 'spec_helper'
require 'kitchen/provisioner/ruby_roles'

describe Kitchen::Provisioner::RubyRoles do
  class BogusInstance
    def logger
    end
  end

  before do
    # Sorry, can't use FakeFS because chef completely bypasses the
    # entire File api when reading the file.
    FileUtils.mkdir_p("tmp/roles")
  end

  after do
    FileUtils.rm_r("tmp/roles")
  end

  it "converts any existing Ruby chef roles into JSON" do
    File.open("tmp/roles/role1.rb", "w+") do |role|
      role.puts <<EOC
name        "role1"
description "I define how things work"

run_list("recipe[test::role1]")
EOC
    end

    File.open("tmp/roles/role2.rb", "w+") do |role|
      role.puts <<EOC
name        "role2"
description "I define how other things work"

run_list("recipe[test::role2]")
EOC
    end

    File.open("tmp/roles/role3.js", "w+") do |role|
      role.puts "This is role thingy 3"
    end

    provisioner = Kitchen::Provisioner::RubyRoles.new(BogusInstance.new, nil, "tmp/roles")
    provisioner.run_command

    expect(File.exists?("tmp/roles/role1.json")).to be_true
    expect(File.exists?("tmp/roles/role2.json")).to be_true
    expect(File.exists?("tmp/roles/role3.json")).to be_false
  end
end
