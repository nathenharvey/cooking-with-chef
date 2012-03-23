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

mysql_database "create #{app_name} database" do
  host node["database"]["host"]
  username "root"
  password node[:mysql][:server_root_password]
  database node["database"]["database"]
  action :create_db
end

