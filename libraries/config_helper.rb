module ConfigHelper
  def self.property(node, key)
    return nil unless key.is_a?(String) and not key.empty?

    # transform the key into a 'path' into the node structure
    config_path = key.split('.')

    # if a key starts with 'sonar.', this is excluded from the config 'path'
    config_path = config_path.drop(1) if config_path[0] == 'sonar'

    # All configuration keys are read from node['sonarqube']
    config_path = config_path.unshift('sonarqube')

    # If path is [some, config, key], this will eval 'node['some']['config']['key']'
    value = eval("node['" +  config_path.join("']['") + "'] rescue nil")

    # comment out the value if it's an explicit nil value
    prefix = value == nil ? '# ' : ''

    "#{prefix}#{key}=#{value}"
  end
end
