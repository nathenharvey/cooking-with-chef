!SLIDE 
# The Joy of Cooking #
## Whip up a Rails Environment with Chef ##
### Nathen Harvey, [CustomInk.com](http://www.customink.com)

!SLIDE 
# Infrastructure as Code #

* survive the bus
* automate all the things
* lather-rinse-repeat

!SLIDE
# Disposable Servers #

!SLIDE
# Evolution of Server Provisioning #

* Just build it
* Keep notes in server.txt
* Migrate notes to wiki and/or git
* Custom shell scripts
* Systems integration framework

!SLIDE
# When should I use a systems integration framework? #

* When you outgrow Heroku
* . . . but maybe even before that

* Rule of thumb:
  * If you'lll need to configure this project / system again

!SLIDE
# Which framework should I use?#

* Puppet?
* Chef?
* CF Engine?
* Juju?

!SLIDE
# Wrong question! #

* YES - use a systems integration framework
* YES - use something that works for your team
* YES - this is a talk about Chef

!SLIDE
# Chef #

* Declarative - What, not how
* Idempotent - Only take action if required
* Convergent - Takes care of itself

!SLIDE
# How Does Chef Work? #

* First, come up with your policy / specification
* Abstract the **resources** in your spec.

!SLIDE
# Resources  

    @@@ruby
    package "tmux" do
      action :install
    end

    directory "/var/www/railsapps/awesome" do
      owner "apache"
      group "apache"
      action :create
      recursive true
    end

.notes http://wiki.opscode.com/display/chef/Resources

!SLIDE
# How Does Chef Work? #

* First, come up with your policy / specification
* Abstract the **resources** in your spec.
* Write **recipes**

!SLIDE
# Recipes

    @@@ruby
    include_recipe "app_user"

    app_name = node["app_name"]
    app_user = node["app_user"]
    app_group = node["app_group"]

    %w(releases shared).each do |dir|
      directory "/svr/#{app_name}/#{dir}" do
        mode "0755"
        owner app_user
        group app_group
        recursive true
      end
    end

!SLIDE
# How Does Chef Work? #

* First, come up with your policy / specification
* Abstract the **resources** in your spec.
* Write **recipes**
* Package recipes in **cookbooks**

!SLIDE
# Cookbooks

    |-- ldirectord
    |   |-- README.md
    |   |-- attributes
    |   |   `-- default.rb
    |   |-- metadata.rb
    |   |-- recipes
    |   |   `-- default.rb
    |   `-- templates
    |       `-- default
    |           `-- site.cf.erb

!SLIDE
# Cookbooks

    |-- monit
    |   |-- README.rdoc
    |   |-- attributes
    |   |   `-- default.rb
    |   |-- files
    |   |   `-- ubuntu
    |   |       `-- monit.default
    |   |-- metadata.rb
    |   |-- recipes
    |   |   `-- default.rb
    |   `-- templates
    |       `-- default
    |           `-- monitrc.erb


!SLIDE
# How Does Chef Work? #

* First, come up with your policy / specification
* Abstract the **resources** in your spec.
* Write **recipes**
* Package recipes in **cookbooks**
* Apply recipes to **nodes**

!SLIDE
# Nodes

* Representation of a host
  * runs the Chef client
  * has attributes
  * has a list of recipes to be applied

.notes http://wiki.opscode.com/display/chef/Nodes

!SLIDE
# How Does Chef Work? #

* First, come up with your policy / specification
* Abstract the **resources** in your spec.
* Write **recipes**
* Package recipes in **cookbooks**
* Apply recipes to **nodes**
* Group things into **roles**

!SLIDE
# Roles

* mechanism for easily composing sets of functionality
* have attributes and a list of recipes to be applied

!SLIDE
# Roles

    @@@ruby
    name "base"
    description "Base of all nodes"
    default_attributes(
      "newrelic" => {
        "license_key" => "cbb1f5..."
      }
    )

    run_list(
      "recipe[base_config]",
      "recipe[users]",
      "recipe[groups]",
      "recipe[sudo]"
    )

.notes http://wiki.opscode.com/display/chef/Roles

!SLIDE
# How Does Chef Work? #

* First, come up with your policy / specification
* Abstract the **resources** in your spec.
* Write **recipes**
* Package recipes in **cookbooks**
* Apply recipes to **nodes**
* Group things into **roles**

!SLIDE
# Chef #

* API
* client
* command-line tool -  knife
* REPL - shef
* inspection library - ohai 
* community site - community.opscode.com 

!SLIDE
# Chef's view of the world #

* node
* role
* environment
* data bag
* cookbooks

!SLIDE
# Anatomny of a Chef run #

* first
* second
* third

!SLIDE 
# Cookbooks #

* the 'gems' of chef
* foo..
* bar...

