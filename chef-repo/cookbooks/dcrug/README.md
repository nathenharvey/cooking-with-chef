Description
===========

Configures a node, or nodes, for the dcrug rails application.

Requirements
============

Requires the following cookbooks:

* apache2
* bundler
* database
* mysql

Attributes
==========

* `["database"]["host"]` - the host where the dcrug database will run
* `["database"]["user"]` - the database user for the dcrug database
* `["database"]["pw"]`   - the password for the database user
* `["database"]["name"]` - the name of the dcrug database

Recipes
======

default
------

The default recipe doesn't do anything at the moment

web
---

The web recipe configures an application server for the dcrug application.  
A database.yml and initial directory structure are created.

db
--

The db recipe:

* installs mysql server
* creates the database
* creates a database user

Usage
=====

Include the proper recipes to configures a node for the dcrug rails application.

    include_recipe "dcrug::web"
    include_recipe "dcrug::db"

Or add it to your role, or directly to a node's recipes.

