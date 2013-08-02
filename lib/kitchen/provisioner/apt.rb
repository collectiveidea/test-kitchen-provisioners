require 'kitchen'
require 'kitchen/provisioner/base'

module Kitchen
  module Provisioner

    # Apt Provisioner
    # This makes sure that aptitude is up-to-date at the beginning of the
    # chef run before cookbooks are pulled in.
    class Apt < Base
      def run_command
        sudo("aptitude update")
      end
    end
  end
end
