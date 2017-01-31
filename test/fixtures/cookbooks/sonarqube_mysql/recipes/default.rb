include_recipe 'yum-centos' if node['platform_family'] == 'rhel'
include_recipe 'yum-mysql-community::mysql57' if node['platform_family'] == 'rhel'
build_essential 'install'
mysql_client 'default' do
  package_name 'mysql-community-devel'
  action :create
end
chef_gem 'mysql2' do
  compile_time false
end
Chef::Recipe.send(:include, OpenSSLCookbook::RandomPassword)
node.normal_unless['sonarqube_mysql']['mysql_root_pw'] = random_password
mysql_service 'sonarqube' do
  version '5.7'
  initial_root_password node['sonarqube_mysql']['mysql_root_pw']
  action [:create, :start]
end
mysql_connection_info = {
  host: '127.0.0.1',
  username: 'root',
  password: node['sonarqube_mysql']['mysql_root_pw']
}

mysql_database 'sonar' do
  connection mysql_connection_info
  action :create
end

node.normal_unless['sonarqube_mysql']['mysql_sonarqube_pw'] = random_password
mysql_database_user 'sonar' do
  connection mysql_connection_info
  password node['sonarqube_mysql']['mysql_sonarqube_pw']
  database_name 'sonar'
  action :grant
end

node.default['sonarqube']['jdbc']['password'] = node['sonarqube_mysql']['mysql_sonarqube_pw']
