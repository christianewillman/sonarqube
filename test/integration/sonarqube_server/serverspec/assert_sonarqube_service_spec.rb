require 'serverspec'

set :backend, :exec

describe port(9000) do
  # initial sleep to let the service finish starting up
  sleep(30)
  it { should be_listening }
end

describe service('sonarqube') do
  it { should be_enabled }
  it { should be_running }
end

describe process('wrapper') do
  its(:user) { should eq 'sonarqube' }
end
