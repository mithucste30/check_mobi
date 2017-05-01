require 'helper'

describe CheckMobi::Resources::Voice::Actions::Hangup do

  before do
    CheckMobi.api_key = ENV['API_KEY']

    @resource = CheckMobi::Resources::Voice::Call.new(
        to: ENV['PHONE_NUMBER']
    )

    @hangup_action = CheckMobi::Resources::Voice::Actions::Hangup.new
  end

  it 'should set action name implicitly' do
    @hangup_action.action.must_equal 'hangup'
  end

  it 'should not allow setting action name' do
    @hangup_action.respond_to?(:action=).must_equal false
  end

  it 'should add hangup event correctly' do
    @resource.events << @hangup_action
    @resource.events.length.must_equal 1
    @resource.events.first.action.must_equal @hangup_action.class.name.split('::').last.underscore!
  end

  it 'should build hashes correctly' do
    @resource.events << @hangup_action
    hash = @resource.to_hash
    hash.keys.must_include(:events)
    hash[:events].must_be_instance_of Array
    hash[:events].first.must_be_instance_of Hash
    hash[:events].first[:action].must_equal @hangup_action.class.name.split('::').last.underscore!
  end

  it 'should pass with invalid reason' do
    @hangup_action.reason = 'xxxx'
    @resource.events << @hangup_action
    response = @resource.perform
    response.status_code.must_equal '200'
  end

  it 'should pass with valid reason' do
    @hangup_action.reason = 'busy'
    @resource.events << @hangup_action
    response = @resource.perform
    response.status_code.must_equal '200'
  end

  it 'should pass without any reason' do
    @resource.events << @hangup_action
    response = @resource.perform
    response.status_code.must_equal '200'
  end

end