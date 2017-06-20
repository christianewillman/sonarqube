default['sonarqube']['plugin']['mirror'] = 'https://sonarsource.bintray.com/Distribution'

default['sonarqube']['plugin']['dir'] = "/opt/sonarqube-#{node['sonarqube']['version']}/extensions/plugins"

# hash with plugin:version pairs like
# default['sonarqube']['plugin']['list'] = { 'ldap' => '2.1.0.507'}
# plugin that is mentioned enables its configuration
# (in sonar we cannot disable plugin we can either install it or uninstall it)
default['sonarqube']['plugin']['list'] = {}
