require 'helper'

describe CheckMobi::Resources::Voice::Actions::Wait do
  before do
    CheckMobi.configure do |c|
      c.api_key = ENV['API_KEY']
    end

    @resource = CheckMobi::Resources::Voice::Call.new(
        to: ENV['PHONE_NUMBER'],
        from: ENV['PHONE_NUMBER']
    )

    @wait_action = CheckMobi::Resources::Voice::Actions::Wait.new
  end

  it 'should set default values' do
    @wait_action.action.must_equal 'wait'
    @wait_action.length.must_equal 1
  end

  it 'should not allow setting action name' do
    @wait_action.respond_to?(:action=).must_equal false
  end

  it 'should add speak event correctly' do
    @resource.events << @wait_action
    @resource.events.length.must_equal 1
    @resource.events.first.action.must_equal @wait_action.class.name.split('::').last.underscore!
  end

  it 'should build hashes correctly' do
    @resource.events << @wait_action
    hash = @resource.to_hash
    hash.keys.must_include(:events)
    hash[:events].must_be_instance_of Array
    hash[:events].first.must_be_instance_of Hash
    hash[:events].first[:action].must_equal @wait_action.class.name.split('::').last.underscore!
  end

  it 'should fail with invalid length' do
    @wait_action.length = 0
    @resource.events << @wait_action
    response = @resource.perform
    response.status_code.must_equal '400'
    response.code.must_equal 10
  end

  it 'should pass with valid length' do
    @wait_action.length = 3
    @resource.events << @wait_action
    response = @resource.perform
    response.status_code.must_equal '200'
  end

end