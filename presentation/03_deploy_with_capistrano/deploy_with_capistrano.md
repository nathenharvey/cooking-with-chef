!SLIDE 
# Deploying with Capistrano #

Without Chef:
    
    @@@ ruby
    role :web, "web01","web02","web03"

!SLIDE
# Deploying with Capistrano #

With Chef search

    @@@ ruby 
    webservers = []
    web_query = Chef::Search::Query.new
    web_query.search(:node, 
                'role:dcrug_web') do |h|
      webservers << h["fqdn"]
    end

    role :web, *webservers
