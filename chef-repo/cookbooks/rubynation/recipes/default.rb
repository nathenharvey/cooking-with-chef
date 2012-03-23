#
# Cookbook Name:: rubynation
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

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
  docroot "#{deploy_to}/current/public"
  server_name "#{app_name}.#{node["domain"]}"
  server_aliases [ app_name, "localhost", node["hostname"] ]
  rails_env "production"
end

case node[:platform]
when "centos","redhat","fedora","suse"
  http_path = "/etc/httpd/conf"
when "debian","ubuntu"
  http_path = "/etc/apache2"
end

execute "disable default" do
  command "a2dissite default"
  only_if "ls #{http_path}/sites-enabled/000-default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

