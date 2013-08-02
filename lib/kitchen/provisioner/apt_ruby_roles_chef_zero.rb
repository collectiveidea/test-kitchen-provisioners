require 'kitchen/provisioner/apt'
require 'kitchen/provisioner/ruby_roles'
require 'kitchen/provisioner/chef_zero'

module Kitchen
  module Provisioner

    # This Provisioner combines the roles of the Apt, Ruby Roles, and ChefZero
    # provisioners, to ensure a server is ready to run before ChefZero starts its magic
    class AptRubyRolesChefZero < Base
      def initialize(instance, options)
        super
        @apt = Apt.new(instance, options)
        @chef_zero = ChefZero.new(instance, options)
        @ruby_roles = RubyRoles.new(instance, options, File.join(@chef_zero.home_path, "roles"))
      end

      def install_command
        @chef_zero.install_command
      end

      def init_command
        @chef_zero.init_command
      end

      def create_sandbox
        @chef_zero.create_sandbox
      end

      def prepare_command
        @chef_zero.prepare_command
      end

      def run_command
        @apt.run_command
        @ruby_roles.run_command
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
