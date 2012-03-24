#
# Cookbook Name:: rubynation
# Recipe:: db
#
# Copyright 2012, Nathen Harvey
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
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
