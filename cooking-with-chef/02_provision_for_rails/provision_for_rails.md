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
# Create some roles #

* base_ubuntu
* rubynation_web
* rubynation_db

!SLIDE
# Assign the roles to our nodes #

* Via the Web UI
* Using knife

!SLIDE
# Run chef #

* knife ssh
* vagrant provision

!SLIDE
# Review #

* Server provisioned and communicating with the Chef API
* Apache and Passenger installed with a default configuration
* MySQL installed and running

