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

