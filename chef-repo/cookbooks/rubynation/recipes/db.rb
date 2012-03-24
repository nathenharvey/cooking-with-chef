#
# Cookbook Name:: rubynation
# Recipe:: db
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
deploy_to = "/u/apps"
app_name = "rubynation"
app_user = "www-data"
app_group = "www-data"

template "#{deploy_to}/#{app_name}/shared/config/database.yml" do
  owner app_user
  group app_group
  mode "0664"
  action :create
  variables(
    :db_host => node["database"]["host"],
    :db_user => node["database"]["user"],
    :db_pw   => node["database"]["pw"],
    :db_database   => node["database"]["name"]
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
  database_name node["database"]["name"]
  host "%"
  action :grant
end

template "/root/.my.cnf" do
  owner "root"
  group "root"
  mode  "0600"
  source "my.cnf.erb"
  variables(
    :mysql_password => node['mysql']['server_root_password']
  )
end
