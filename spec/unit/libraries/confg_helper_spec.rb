require_relative '../../../libraries/config_helper'

describe ConfigHelper do
  describe '#property' do

    let(:node) do
      {
          'sonarqube' => {
              'jdbc' => {
                  'username' => 'sonar',
                  'password' => nil,
                  'url' => 'jdbc://something'
              },
              'http' => {
                  'proxyHost' => nil,
                  'proxyPort' => 9128
              }
          }
      }
    end

    it 'returns nil when called with a key nil' do
      expect(ConfigHelper.property(node, nil)).to eq nil
    end

    it 'returns nil when called with a key that is not a String' do
      expect(ConfigHelper.property(node, {})).to eq nil
    end

    describe 'called with key starting with \'sonar.\'' do

      it 'returns a commented out property for non existing keys' do
        expect(ConfigHelper.property(node, 'sonar.does.not.exist')).to eq '# sonar.does.not.exist='
      end

      it 'returns a commented out property for a key that is explicitly nil ' do
        expect(ConfigHelper.property(node, 'sonar.jdbc.password')).to eq '# sonar.jdbc.password='
      end

      it 'looks up the value in the node structure' do
        expect(ConfigHelper.property(node, 'sonar.jdbc.username')).to eq 'sonar.jdbc.username=sonar'
      end
    end

    describe 'called with key not starting with \'sonar.\'' do

      it 'returns a commented out property for non existing keys' do
        expect(ConfigHelper.property(node, 'does.not.exist')).to eq '# does.not.exist='
      end

      it 'returns a commented out property for a key that is explicitly nil ' do
        expect(ConfigHelper.property(node, 'http.proxyHost')).to eq '# http.proxyHost='
      end

      it 'looks up the value in the node structure' do
        expect(ConfigHelper.property(node, 'http.proxyPort')).to eq 'http.proxyPort=9128'
      end
    end
  end
end