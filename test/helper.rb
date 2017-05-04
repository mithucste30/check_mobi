require 'check_mobi'
# Dir['check_mobi/*.rb'].each { |file| require file }
# Dir['check_mobi/resources/**/*.rb'].each { |file| require file }
require 'minitest/spec'
require 'minitest/autorun'
require "minitest/focus"
require 'webmock/minitest'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<API_KEY>') { ENV['API_KEY'] }
end

WebMock.disable_net_connect!

def stub_get_request(url)
  stub_request(:get, url)
end

def stub_delete_request(url)
  stub_request(:delete, url)
end

def stub_post_request(url)
  stub_request(:post, url)
end

def headers_without_authorization
  {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
  }
end

def headers_with_authorization
  headers_without_authorization.merge!({'Authorization': ENV['API_KEY']})
end