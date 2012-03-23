!SLIDE 
# Deploying with Capistrano #

Without Chef:
    
    @@@ ruby
    set :webservers, ["web01","web02","web03"]

!SLIDE
# Deploying with Capistrano #

With Chef search

    @@@ ruby 
    webservers = []
    webserver_query = Chef::Search::Query.new
    results = webserver_query.search(:node, 
                        'role:rubynation_web')
    results.each do |host|
      webservers << host["fqdn"]
    end
