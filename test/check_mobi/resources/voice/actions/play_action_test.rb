require 'helper'

describe CheckMobi::Resources::Voice::Actions::Play do
  before do
    CheckMobi.configure do |c|
      c.api_key = ENV['API_KEY']
    end

    @resource = CheckMobi::Resources::Voice::Call.new(
        to: ENV['PHONE_NUMBER'],
        from: ENV['PHONE_NUMBER']
    )

    @play_action = CheckMobi::Resources::Voice::Actions::Play.new
  end

  it 'should set action name implicitly' do
    @play_action.action.must_equal 'play'
  end

  it 'should not allow setting action name' do
    @play_action.respond_to?(:action=).must_equal false
  end

  it 'should add speak event correctly' do
    @resource.events << @play_action
    @resource.events.length.must_equal 1
    @resource.events.first.action.must_equal @play_action.class.name.split('::').last.underscore!
  end

  it 'should build hashes correctly' do
    @resource.events << @play_action
    hash = @resource.to_hash
    hash.keys.must_include(:events)
    hash[:events].must_be_instance_of Array
    hash[:events].first.must_be_instance_of Hash
    hash[:events].first[:action].must_equal @play_action.class.name.split('::').last.underscore!
  end

  it 'should fail without audio url' do
    @resource.events << @play_action
    response = @resource.perform
    response.status_code.must_equal '400'
    response.code.must_equal 10
  end

  it 'should pass with audio url' do
    @play_action.url = ENV['AUDIO_URL']
    @resource.events << @play_action
    response = @resource.perform
    response.status_code.must_equal '200'
  end

end