!SLIDE
# Initial set-up steps #

* Register with hosted chef
* create a chef-repo
* Install chef
* configure knife.rb
* configure Vagrant file
* register Vagrant instance with Chef hosted

!SLIDE 
# Provision for Rails #

* apache
* passenger
* mysql
* rails application

!SLIDE commandline incremental
# Add apache2 cookbook #

    $ knife cookbook site install passenger_apache2
    $ knife cookbook site install apache2 (installed by default?)
    $ knife cookbook site install build-essential (installed by default?)

!SLIDE code

!SLIDE 
# apache2 Cookbook #

recipes/default.rb

    @@@ruby
    package "apache2" do
      package_name node[:apache][:package]
      action :install
    end

* `package` is a Chef resource
* Where is `node[:apache][:package]` defined?

!SLIDE
# apache2 attributes/default.rb #

    @@@ruby
    case platform
    when "redhat","centos","scientific","fedora","suse"
      set[:apache][:package] = "httpd"
    when "debian","ubuntu"
      set[:apache][:package] = "apache2"
    when "arch"
      set[:apache][:package] = "apache"
    when "freebsd"
      set[:apache][:package] = "apache22"
    else
      ...
    end
 
 
 
!SLIDE
# Enable Apache on reboot 

    @@@ruby
    service "apache2" do
      action :enable
    end  

!SLIDE
# Configure Apache #

    @@@ruby
    template "apache2.conf" do
      case node[:platform]
      when "redhat", "centos", "scientific", "fedora", "arch"
        path "#{node[:apache][:dir]}/conf/httpd.conf"
      when "debian","ubuntu"
        path "#{node[:apache][:dir]}/apache2.conf"
      when "freebsd"
        path "#{node[:apache][:dir]}/httpd.conf"
      end
      source "apache2.conf.erb"
      owner "root"
      group node[:apache][:root_group]
      mode 0644
      notifies :restart, resources(:service => "apache2")
    end

!SLIDE
# Add to our role #

    @@@ruby
    name "my_app"
    description "Server running my application"
    run_list(
      "recipe[passenger_apache2::mod_rails]"
    )

mod_rails includes the default recipe which includes installing basic apache

!SLIDE commandline incremental
# Add MySQL Server to our Server #

    $ knife cookbook site install mysql
    $ knife cookbook site install openssl (installed by default?)
    $ knife cookbook site install build-essential (installed by default?)
    $ knife cookbook site install ruby-dev (installed by default?)

!SLIDE
# Add MySQL to our role #

    @@@ruby
    name "my_app"
    description "Server running my application"
    run_list(
      "recipe[passenger_apache2::mod_rails]",
      "recipe[mysql::server]"
    )

!SLIDE
# We now have #

* Server provisioned and communicating with the Chef API
* Apache and Passenger installed with a default configuration
* MySQL installed and running

!SLIDE
# Next #

* Prepare the application to run a Rails application

!SLIDE commandline incremental
# Creating a cookbook for our app #

    $knife cookbook create my_app

