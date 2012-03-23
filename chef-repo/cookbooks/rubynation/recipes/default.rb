#
# Cookbook Name:: rubynation
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
include_recipe "passenger_apache2" 

deploy_to = "/u/apps"
app_user = "www-data"
app_group = "www-data"
app_name = "rubynation"

%w(releases shared shared/system shared/pids shared/logs shared/config).each do |dir|
  directory "#{deploy_to}/#{app_name}/#{dir}" do
    action :create
    owner app_user
    group app_group
    mode "0664"
    recursive true
  end
end

template "#{deploy_to}/#{app_name}/shared/config/database.yml" do
  owner app_user
  group app_group
  mode "0664"
  action :create
  variables(
    :db_host => node["database"]["host"],
    :db_user => node["database"]["user"],
    :db_pw   => node["database"]["pw"],
    :db_database   => node["database"]["database"]
  )
end

gem_package "mysql"

mysql_connection_info = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}

mysql_database app_name do
  connection mysql_connection_info
  action :create
end

mysql_database_user node["database"]["user"] do
  connection mysql_connection_info
  password  node["database"]["pw"]
  database_name node["database"]["database"]
  host "%"
  action :grant
end

web_app app_name do
  cookbook "passenger_apache2"
  docroot "#{deploy_to}/public"
  server_name "#{app_name}.#{node["domain"]}"
  server_aliases [ app_name, "localhost", node["hostname"] ]
  rails_env "production"
end
