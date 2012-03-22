# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "ubuntu64-ruby-1.9"

  config.vm.forward_port 80, 8080

  config.vm.provision :chef_client do |chef|
    chef.chef_server_url = "https://api.opscode.com/organizations/rubynation"
    chef.node_name = "rubynation.vagrant.local"
    chef.validation_key_path = "chef-repo/.chef/rubynation-validator.pem"
    chef.validation_client_name = "rubynation-validator"
  end
end
