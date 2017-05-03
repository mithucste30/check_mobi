require 'helper'

describe CheckMobi::Resources::PhoneValidation::ValidationStatus do
  before do
    @id = 'xxxxxx'
    @endpoint = "https://api.checkmobi.com/v1/validation/status/#{@id}"

    CheckMobi.configure do |c|
      c.api_key = ENV['API_KEY']
    end

    @resource = CheckMobi::Resources::PhoneValidation::ValidationStatus.new
    stub_get_request(@endpoint)
  end

  it 'validation status resource should request properly' do
    @resource.id = @id
    @resource.perform
    assert_requested(:get,
                     @endpoint,
                     headers: headers_with_authorization,
                     times: 1)
  end
end
