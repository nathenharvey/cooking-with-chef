# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box_url = "https://s3.amazonaws.com/customink-vagrant-boxes/ubuntu/ubuntu64-10.0.4-ruby-1.9.3.box"
  config.vm.box = "ubuntu64-10.0.4-ruby-1.9.3"

  config.vm.forward_port 80, 8080

  config.vm.provision :chef_client do |chef|
    chef.chef_server_url = "https://api.opscode.com/organizations/rubynation"
    chef.node_name = "dcrug.local"
    chef.validation_key_path = "chef-repo/.chef/rubynation-validator.pem"
    chef.validation_client_name = "rubynation-validator"
  end
end
