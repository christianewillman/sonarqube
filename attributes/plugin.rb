default['sonarqube']['plugin']['mirror'] = 'https://binaries.sonarsource.com/Distribution'

default['sonarqube']['plugin']['dir'] = "/opt/sonarqube-#{node['sonarqube']['version']}/extensions/plugins"

# hash with plugin:version pairs like
# default['sonarqube']['plugin']['list'] = { 'ldap' {"version" => '2.1.0.507', 'template' => true }}
# plugin that is mentioned enables its configuration
# (in sonar we cannot disable plugin we can either install it or uninstall it)
default['sonarqube']['plugin']['list'] = {}
