require 'helper'

describe 'configuration' do

    before do
      CheckMobi.reset
    end

    describe '.api_key' do
      it 'should return default key' do
          CheckMobi.api_key.must_equal CheckMobi::Configuration::DEFAULT_API_KEY
      end
    end

    describe '.format' do
      it 'should return default fomat' do
          CheckMobi.format.must_equal CheckMobi::Configuration::DEFAULT_FORMAT
      end
    end

    describe '.method' do
      it 'should return default method' do
          CheckMobi.method.must_equal CheckMobi::Configuration::DEFAULT_METHOD
      end
    end

    describe '.user_agent' do
      it 'should return default user agent' do
        CheckMobi.user_agent.must_equal CheckMobi::Configuration::DEFAULT_USER_AGENT
      end
    end

    CheckMobi::Configuration::VALID_CONFIG_KEYS.each do |key|
      describe ".#{key}" do
        it 'should return the default value' do
          CheckMobi.send(key).must_equal CheckMobi::Configuration.const_get("DEFAULT_#{key.upcase}")
        end
      end
    end

    describe '.configure' do
      CheckMobi::Configuration::VALID_CONFIG_KEYS.each do |key|
        it "should set the #{key}" do
          CheckMobi.configure do |config|
            config.send("#{key}=", key)
            CheckMobi.send(key).must_equal key
          end # CheckMobi.configure
        end # describe 'it should set the key'
      end # CheckMobi::Configuration::VALID_CONFIG_KEYS
    end # describe '.configure'

    after do
      CheckMobi.reset
    end
end
