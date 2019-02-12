property :plugin_name, String, name_property: true
property :version, String

actions :install, :uninstall
default_action :install

sonarqube_user = node['sonarqube']['user']
sonarqube_group = node['sonarqube']['group']

action :install do
  service 'sonarqube' do
    action :nothing
  end

  # we need to remove previous plugin versions first
  Dir[plugin_file_name_wildcard].each do |path|
    file ::File.expand_path(path) do
      action :delete
    end
  end

  remote_file plugin_path do
    source plugin_url
    mode 0755
    owner sonarqube_user
    group sonarqube_group
    notifies :restart, 'service[sonarqube]', :delayed
  end
end

action :uninstall do
  service 'sonarqube' do
    action :nothing
  end

  file plugin_path do
    action :delete
    notifies :restart, 'service[sonarqube]', :delayed
  end
end

def plugin_url
  sonarqube_plugin_mirror = node['sonarqube']['plugin']['mirror']

  "#{sonarqube_plugin_mirror}/sonar-#{plugin_name}-plugin/#{plugin_file_name}"
end

def plugin_path
  sonarqube_plugin_dir = node['sonarqube']['plugin']['dir']

  ::File.join(sonarqube_plugin_dir, plugin_file_name)
end

def plugin_file_name
  "sonar-#{plugin_name}-plugin-#{version}.jar"
end

def plugin_file_name_wildcard
  plugin_file_name_without_version = "sonar-#{plugin_name}-plugin-*"
  ::File.join(node['sonarqube']['plugin']['dir'], plugin_file_name_without_version)
end
