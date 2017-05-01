require 'helper'

describe CheckMobi::Resources::CheckNumber do
  before do
    CheckMobi.api_key = ENV['API_KEY']
    @endpoint = 'https://api.checkmobi.com/v1/checknumber'
    @resource_class = CheckMobi::Resources::CheckNumber
    stub_post_request(@endpoint)
  end

  it 'should request without phone number' do
    resource = @resource_class.new
    response = resource.perform
    assert_requested(:post, @endpoint, headers: headers_with_authorization, body: {number: nil}.to_json, times: 1)
  end

  it 'should request with invalid phone number' do
    resource = @resource_class.new(phone_number: '000000000')
    resource.perform
    assert_requested(:post, @endpoint, headers: headers_with_authorization, body: {number: '000000000'}.to_json, times: 1)
  end

  it 'should request without api key' do
    CheckMobi.api_key = nil
    resource = @resource_class.new(phone_number: ENV['PHONE_NUMBER'])
    resource.perform
    assert_requested(:post, @endpoint, headers: headers_without_authorization, body: {number: ENV['PHONE_NUMBER']}.to_json, times: 1)
  end

  it 'should request with api key and phone number' do
    resource = @resource_class.new(phone_number: ENV['PHONE_NUMBER'])
    resource.perform
    assert_requested(:post, @endpoint, headers: headers_with_authorization, body: {number: ENV['PHONE_NUMBER']}.to_json, times: 1)
  end
end