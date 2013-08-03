require 'kitchen/provisioner/apt'
require 'kitchen/provisioner/ruby_roles'
require 'kitchen/provisioner/chef_zero'

module Kitchen
  module Provisioner

    # This Provisioner combines the roles of the Apt, Ruby Roles, and ChefZero
    # provisioners, to ensure a server is ready to run before ChefZero starts its magic
    # Must be named "Chef..." otherwise TestKitchen won't understand that we intend to use chef
    class ChefAptRubyRolesChefZero < Base
      def initialize(instance, options)
        super
        @apt = Apt.new(instance, options)
        @chef_zero = ChefZero.new(instance, options)
        @ruby_roles = RubyRoles.new(instance, options)
      end

      def install_command
        @chef_zero.install_command
      end

      def init_command
        @chef_zero.init_command
      end

      # Let chef-zero create the sandbox then convert the Ruby-based role files
      # into JSON before uploads happen (which happen right after this returns)
      def create_sandbox
        sandbox_path = @chef_zero.create_sandbox
        @ruby_roles.roles_path = File.join(sandbox_path, "roles")
        @ruby_roles.create_sandbox
        sandbox_path
      end

      def prepare_command
        @chef_zero.prepare_command
      end

      # Run the apt provisioner before starting up chef-zero
      def run_command
        @apt.run_command
        @chef_zero.run_command
      end

      def cleanup_sandbox
        @chef_zero.cleanup_sandbox
      end

      def home_path
        @chef_zero.home_path
      end
    end

  end
end
