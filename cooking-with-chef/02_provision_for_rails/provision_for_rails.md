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
# Add passenger_apache2 cookbook #

    $ knife cookbook site install passenger_apache2

.notes http://community.opscode.com/cookbooks/passenger_apache2

!SLIDE 
# knife cookbook site install #

1. A new "pristine copy" branch is created in git for tracking the
   upstream;
1. All existing cookbooks are removed from the branch;
1. The cookbook is downloaded from the cookbook site in tarball form;
1. The downloaded cookbook is untarred, and its contents commited via git;
1. The pristine copy branch is merged into the master branch.

!SLIDE commandline incremental
# Add mysql cookbook #

    $ knife cookbook site install mysql

.notes http://community.opscode.com/cookbooks/mysql

!SLIDE commandline incremental
# Create a Cookbook for our app #

    $ knife cookbook create rubynation
    
    ** Creating cookbook rubynation
    ** Creating README for cookbook: rubynation
    ** Creating metadata for cookbook: rubynation

.notes http://wiki.opscode.com/display/chef/Managing+Cookbooks+With+Knife#ManagingCookbooksWithKnife-create

!SLIDE
# Write our Cookbook #

* web.rb
* db.rb

!SLIDE
# Web Cookbook #

Set-up some directories

    @@@ ruby
    %w(releases shared shared/system shared/pids shared/logs shared/config).each do |dir|
      directory "#{deploy_to}/#{app_name}/#{dir}" do
        action :create
        owner app_user
        group app_group
        mode "0664"
        recursive true
      end
    end

!SLIDE
# Web Cookbook #

Configure apache / passenger

    @@@ ruby
    web_app app_name do
      docroot "#{deploy_to}/current/public"
      server_name "#{app_name}.#{node["domain"]}"
      server_aliases [ app_name, "localhost", node["hostname"] ]
      rails_env "production"
    end

!SLIDE
# Database Cookbook #

Create the database 

    @@@ ruby
    mysql_connection_info = {
      :host => "localhost", 
      :username => 'root', 
      :password => 
        node['mysql']['server_root_password']
    }
    
    mysql_database app_name do
      connection mysql_connection_info
      action :create
    end

!SLIDE
#Database Cookbook #

Create the database user

    @@@ ruby
    mysql_database_user node["database"]["user"] do
      connection mysql_connection_info
      password  node["database"]["pw"]
      database_name node["database"]["database"]
      host "%"
      action :grant
    end

!SLIDE
# Create some roles #

* Group recipes together using roles
* Apply roles to nodes
* Our roles:
  * base_ubuntu
  * rubynation_web
  * rubynation_db

!SLIDE
# base_ubuntu Role

    @@@ ruby
    name "base_ubuntu"
    description "all Ubuntu servers"
    run_list(
      "recipe[apt]"
    )

!SLIDE
# rubynation_web Role

    @@@ ruby
    name "rubynation_web"
    description "Rubynation Webserver nodes"
    run_list(
      "recipe[rubynation::web]"
    )

!SLIDE
# rubynation_db Role

    @@@ ruby
    name "rubynation_db"
    description "Rubynation Database nodes"
    run_list(
      "recipe[rubynation::db]"
    )

!SLIDE commandline incremental
# Upload the roles to the server

    $ knife role from file roles/base_ubuntu
    $ knife role from file roles/rubynation_web
    $ knife role from file roles/rubynation_db

!SLIDE commandline
# Assign the roles to our nodes #

    $ knife node run_list add rubynation.local "role[base_ubuntu]"
    $ knife node run_list add rubynation.local "role[rubynation_web]"
    $ knife node run_list add rubynation.local "role[rubynation_db]"

!SLIDE
# Run chef-client #

* automatically
* knife ssh
* vagrant provision

!SLIDE
# Review #

* Server provisioned and communicating with the Chef API
* Apache and Passenger installed with a default configuration
* MySQL installed and running

