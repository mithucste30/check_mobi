require 'helper'

describe CheckMobi::Resources::Voice::Actions::Speak do
  before do
    @endpoint = 'https://api.checkmobi.com/v1/call'

    CheckMobi.configure do |c|
      c.api_key = ENV['API_KEY']
    end

    @resource = CheckMobi::Resources::Voice::Call.new(
        to: ENV['PHONE_NUMBER'],
        from: ENV['PHONE_NUMBER']
    )

    @speak_action = CheckMobi::Resources::Voice::Actions::Speak.new
  end

  it 'should set default values' do
    @speak_action.action.must_equal 'speak'
    @speak_action.loop.must_equal 1
    @speak_action.voice.must_equal 'WOMAN'
    @speak_action.language.must_equal 'en-US'
  end

  it 'should not allow setting action name' do
    @speak_action.respond_to?(:action=).must_equal false
  end

  it 'should add speak event correctly' do
    @resource.events << @speak_action
    @resource.events.length.must_equal 1
    @resource.events.first.action.must_equal @speak_action.class.name.split('::').last.underscore!
  end

  it 'should build hashes correctly' do
    @resource.events << @speak_action
    hash = @resource.to_hash
    hash.keys.must_include(:events)
    hash[:events].must_be_instance_of Array
    hash[:events].first.must_be_instance_of Hash
    hash[:events].first[:action].must_equal @speak_action.class.name.split('::').last.underscore!
  end

  it 'should request without text' do
    stub_post_request(@endpoint).to_return(status: 400, body: {code: 10, error: 'Invalid request Payload'}.to_json)
    @resource.events << @speak_action
    response = @resource.perform
    response.status_code.must_equal '400'
    response.code.must_equal 10
    assert_requested(:post,
                     @endpoint,
                     body: @resource.to_hash,
                     headers: headers_with_authorization,
                     times: 1)
  end

  it 'should pass with text' do
    stub_post_request(@endpoint).to_return(status: 200)
    @speak_action.text = 'sample text'
    @resource.events << @speak_action
    response = @resource.perform
    response.status_code.must_equal '200'
    assert_requested(:post,
                     @endpoint,
                     body: {
                         from: ENV['PHONE_NUMBER'], to: ENV['PHONE_NUMBER'], notification_callback: nil, platform: 'web',
                         events:[
                             {text: 'sample text', loop: 1,voice: 'WOMAN',language: 'en-US',action: 'speak'}
                         ]
                     },
                     headers: headers_with_authorization,
                     times: 1)
  end

end