default['sonarqube']['mirror'] = 'https://sonarsource.bintray.com/Distribution/sonarqube/'
default['sonarqube']['version'] = '5.6.5'
default['sonarqube']['checksum'] = '759668081266773cf91be6d5f0c585a6383dd87f3eabdc555aea7beae98e58b0'
default['sonarqube']['os_kernel'] = 'linux-x86-64'

default['sonarqube']['config']['dir'] = '/opt/sonarqube-%{version}/conf'
default['sonarqube']['config']['file'] = 'sonar.properties'

default['sonarqube']['user'] = 'sonarqube'
default['sonarqube']['group'] = 'sonarqube'

default['sonarqube']['web']['host'] = '0.0.0.0'
default['sonarqube']['web']['context'] = nil
default['sonarqube']['web']['port'] = 9000
default['sonarqube']['web']['https']['port'] = -1 # Default value of -1 leaves https disabled

default['sonarqube']['embeddedDatabase']['dataDir'] = nil
default['sonarqube']['embeddedDatabase']['port'] = 9092

# Populate keys 'host', 'port' and 'database', along with jdbc username and password to use MySQL >= 5.6.
default['sonarqube']['mysqlDatabase'] = {}
# Populate keys 'host', 'port' and 'sid', along with jdbc username and password to use Oracle.
# NOTE: SonarQube does not ship with the Oracle JDBC driver, nor does this cookbook install it.
default['sonarqube']['oracleDatabase'] = {}
# Populate keys 'host', and 'database', along with jdbc username and password to use PostgreSQL.
default['sonarqube']['postgresDatabase'] = {}
# Populate keys 'host', 'port', 'database', and 'integratedSecurity' (true|false), along with jdbc username and password to use MS SQL Server.
# NOTE: You will need to deploy some DLLs for integrated security to work.
default['sonarqube']['mssqlDatabase'] = {}

default['sonarqube']['jdbc']['username'] = 'sonar'
default['sonarqube']['jdbc']['password'] = 'sonar'
default['sonarqube']['jdbc']['url'] = 'jdbc:h2:tcp://localhost:9092/sonar'

default['sonarqube']['jdbc']['maxActive'] = 60
default['sonarqube']['jdbc']['maxIdle'] = 5
default['sonarqube']['jdbc']['minIdle'] = 2
default['sonarqube']['jdbc']['maxWait'] = 5000
default['sonarqube']['jdbc']['minEvictableIdleTimeMillis'] = 600_000
default['sonarqube']['jdbc']['timeBetweenEvictionRunsMillis'] = 30_000

default['sonarqube']['web']['http']['maxThreads'] = 50
default['sonarqube']['web']['http']['minThreads'] = 5
default['sonarqube']['web']['http']['acceptCount'] = 25
default['sonarqube']['web']['https']['minThreads'] = 5
default['sonarqube']['web']['https']['maxThreads'] = 50
default['sonarqube']['web']['https']['acceptCount'] = 25

default['sonarqube']['web']['accessLogs']['enable'] = true
default['sonarqube']['ajp']['port'] = -1

default['sonarqube']['updatecenter']['activate'] = true
default['sonarqube']['http']['proxyHost'] = nil
default['sonarqube']['http']['proxyPort'] = nil
default['sonarqube']['https']['proxyHost'] = nil
default['sonarqube']['https']['proxyPort'] = nil
default['sonarqube']['http']['auth']['ntlm']['domain'] = nil
default['sonarqube']['socksProxyHost'] = nil
default['sonarqube']['socksProxyPort'] = nil
default['sonarqube']['http']['proxyUser'] = nil
default['sonarqube']['http']['proxyPassword'] = nil
default['sonarqube']['notifications']['delay'] = 60
default['sonarqube']['log']['profilingLevel'] = 'NONE'

default['sonarqube']['rails']['dev'] = false

default['sonarqube']['extra_properties'] = [
  # 'sonar.security.realm=LDAP',
  # 'sonar.security.savePassword=false'
]
