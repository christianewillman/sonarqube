node['sonarqube']['plugin']['list'].each_pair do |k, v|
  sonarqube_plugin k do
    version v
    action :install
  end
end
