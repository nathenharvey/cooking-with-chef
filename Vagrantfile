# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box"
  config.vm.box = "opscode-ubuntu-12.04" 

  config.vm.forward_port 80, 8080

  config.vm.provision :chef_client do |chef|
    chef.chef_server_url = "https://api.opscode.com/organizations/rubynation"
    chef.node_name = "dcrug.local"
    chef.validation_key_path = "chef-repo/.chef/rubynation-validator.pem"
    chef.validation_client_name = "rubynation-validator"
  end
end
