source 'https://supermarket.chef.io'

metadata

group :integration do
  cookbook 'apt', '= 2.9.2'
  cookbook 'java', '= 1.27.0'
  cookbook 'sonarqube_plugin_consumer', path: 'test/fixtures/cookbooks/sonarqube_plugin_consumer'
  cookbook 'sonarqube_mysql', path: 'test/fixtures/cookbooks/sonarqube_mysql'
  cookbook 'mysql', '~> 8.0'
  cookbook 'yum-mysql-community', '~> 1.0'
  cookbook 'yum-centos', '~> 1.0'
  cookbook 'yum-epel', '~> 1.0'
  cookbook 'database', '~> 6.1'
end
