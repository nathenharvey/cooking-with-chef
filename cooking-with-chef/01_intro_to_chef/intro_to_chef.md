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

