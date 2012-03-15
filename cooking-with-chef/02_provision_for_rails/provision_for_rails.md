!SLIDE 
# Provision for Rails #

* apache
* passenger
* mysql
* rails application

!SLIDE
# Initial set-up steps #

* Register with hosted chef
* create a chef-repo
* Install chef
* configure knife.rb

!SLIDE
# Adding apache #

* use the community site's apache2 cookbook
* `knife cookbook site install apache`

!SLIDE code

!SLIDE 
# apache2 Cookbook #

`recipes/default.rb`

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
 
 
 
 
