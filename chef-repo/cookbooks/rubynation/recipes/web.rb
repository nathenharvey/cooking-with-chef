#
# Cookbook Name:: rubynation
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe "bundler"

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

