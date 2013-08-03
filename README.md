test-kitchen-provisioners
=========================

A collection of provisioners to be used in [test-kitchen](https://github.com/opscode/test-kitchen) runs to
add functionality to the Provisioner system.

Unfortunately as Provisioners were not built with chaining in mind, these may come across as a bit hackish.

## Usage

    gem install test-kitchen-provisioners

Set the `provisioner` value in `.kitchen.yml` to one of the available provisioners.

## Available Providers

### ChefAptRubyRolesChefZero

    provisioner: chef_apt_ruby_roles_chef_zero

A chain provisioners that ensure:

1. Aptitude update is called before chef-zero starts. This lets us not have to make every single cookbook
reliant on the apt cookbook.
2. Ruby roles get converted to JSON. chef-zero only knows how to work with JSON files, but we like Ruby.
This provider runs against the cookbook sandbox on the host machine before the files are uploaded to the VM
3. Calls the built-in chef-zero provisioner to continue as normal.

