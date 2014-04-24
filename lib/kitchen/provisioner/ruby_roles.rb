require 'kitchen'
require 'kitchen/provisioner/base'
require 'chef'

module Kitchen
  module Provisioner

    # RubyRoles Provisioner
    # This provisioner, when given a path to a cookbook's roles directory, will iterate through
    # each Ruby-written role and generate the JSON version.
    # This then allows the ChefZero tool to pick up these roles, as it only knows about JSON
    class RubyRoles < Base

      attr_accessor :roles_path

      def create_sandbox
        # From https://gist.github.com/red56/834890
        Dir.glob(File.join(@roles_path, "*.rb")).each do |ruby_role_file_name|
          role = ::Chef::Role.new
          role.from_file(ruby_role_file_name)
          json_file_name = ruby_role_file_name.gsub(/rb$/, "json")

          File.open(json_file_name, "w+") do |json_file|
            json_file.write(JSON.pretty_generate(role))
          end
        end
      end

    end

  end
end
