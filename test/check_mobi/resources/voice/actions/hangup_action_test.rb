require 'helper'

describe CheckMobi::Resources::Voice::Actions::Hangup do

  before do
    @endpoint = 'https://api.checkmobi.com/v1/call'

    CheckMobi.api_key = ENV['API_KEY']

    @resource = CheckMobi::Resources::Voice::Call.new(
        to: ENV['PHONE_NUMBER'],
        platform: 'android'
    )

    @hangup_action = CheckMobi::Resources::Voice::Actions::Hangup.new(reason: 'rejected')
  end

  it 'should set action name implicitly' do
    @hangup_action.action.must_equal 'hangup'
  end

  it 'should not allow setting action name' do
    @hangup_action.respond_to?(:action=).must_equal false
  end

  it 'should request properly' do
    stub_post_request(@endpoint)
    @resource.events << @hangup_action
    @resource.perform
    assert_requested(:post, @endpoint,
                     body: {
                         from: nil,
                         to: ENV['PHONE_NUMBER'],
                         notification_callback: nil, platform: 'android',
                         events: [{action: 'hangup', reason: 'rejected'}]
                     },
                     headers: headers_with_authorization,
                     times: 1
    )
  end

end