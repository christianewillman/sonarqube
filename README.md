# sonarqube

Installs and configures [SonarQube server](http://www.sonarqube.org/) and the [SonarQube Scanner](http://docs.sonarqube.org/display/SONAR/Analyzing+with+SonarQube+Scanner).
Provides a LWRP for for installing
[SonarQube plugins](http://docs.sonarqube.org/display/PLUG/Plugin+Library).

## Requirements

### Platforms
- CentOS
- Ubuntu

Tested on:
  - CentOS 6.4
  - Ubuntu 12.04

### Dependencies
SonarQube requires JDK 1.7 or later. Use the [Java Cookbook](https://github.com/agileorbit-cookbooks/java)
to install a suitable Oracle JDK or OpenJDK.

## Recipes

### default
Installs SonarQube Server and manages `sonar.properties`.
In case that *-plugin.conf.erb templates available and plugin list defined, their data will be added to sonar.properties

### scanner
Installs SonarQube Scanner and manages `sonar-runner.properties`.
Adds the SonarQube Scanner to all users' `PATH` via `/etc/profile.d`.

### plugins
Installs SonarQube plugins according to the data in node['sonarqube']['plugin']['list'] attribute
node['sonarqube']['plugin']['list'] hash should contain the following data:
```
{
   plugin_name_without_sonar_prefix: {
        "version": version,
        "template": true (in case that configuration should be in sonar.properties) [false] by default
    }
}
```

Example in role:
```
"sonarqube": {
  "plugin": {
    "list": {
      "ldap": {
        "version": "2.1.0.507",
        "template": true
      },
      "python": {
        "version": "1.8.0.1496"
      },
      "java": {
        "version": "4.10.0.10260"
      },
      "javascript": {
        "version": "3.1.0.5111"
      }
    }
  }
}
```

In case configuration parameters should be added to sonar.properties please follow next steps:
1. In case that *_plugin.conf.erb template already exists, please set the relevant parameters
2. If *_plugin.conf.erb template doesn't exists, please create the relevant template

## LWRP

### sonarqube_plugin
This LWRP manages SonarQube plugins.

The `:install` action installs a SonarQube plugin to an existing SonarQube Server instance.
Plugins are retrieved from
[SonarSource's distribution mirror](https://sonarsource.bintray.com/Distribution/).
The plugin version __must__ be specifed.

```ruby
# Installs version 1.3 of the SonarQube Groovy plugin
sonarqube_plugin 'groovy' do
  version 1.3
end
```

The `:uninstall` action removes a SonarQube plugin.

```ruby
sonarqube_plugin 'groovy' do
  version 1.3
  action :uninstall
end
```

## Usage

### SonarQube Server
On systems that should be SonarQube servers, add `recipe[sonarqube]` to the runlist.

By default, the SonarQube server will connect to an embedded H2 database.
To connect to a different database, override:

- `node['sonarqube']['jdbc']['username']`
- `node['sonarqube']['jdbc']['password']`
- `node['sonarqube']['jdbc']['url']`

### SonarQube Scanner
On systems that need to invoke SonarQube analyses against an existing SonarQube Server
(such as a CI machine), add `recipe[sonarqube::scanner]` to the runlist.

By default, the SonarQube Scanner will search for a SonarQube server running on `localhost:9000`.
To connect to a different SonarQube Server, override:

- `node['sonarqube']['scanner']['host']['url']`

If the SonarQube Server prohibits anonymous users from executing analyses, also override:

- `node['sonarqube']['scanner']['host']['username']`
- `node['sonarqube']['scanner']['host']['password']`

### Advanced Attributes
Browse the `attributes` directory to view advanced attributes.

## Notes

- Does not run `apt::default` on Ubuntu
  - add `apt::default` to your run list before anything else if you need it (e.g. for the Java installation as described in the previous bullet)

## Contributing

### Prerequisites

- [ChefDK](http://downloads.getchef.com/chef-dk/ "ChefDK")
- Recent RuboCop

```
chef gem install rubocop
```

### Testing

Test changes using:

```
chef exec rake
chef exec kitchen verify
```

### Publishing
```
chef exec knife cookbook site share sonarqube "Monitoring & Trending"
```

## Author
Christian Willman <github@willman.io>

## License
MIT
