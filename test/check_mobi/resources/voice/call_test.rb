require 'helper'

describe CheckMobi::Resources::Voice::Call do

  before do
    @resource = CheckMobi::Resources::Voice::Call.new
    @speak_action = CheckMobi::Resources::Voice::Actions::Speak.new
    @play_action = CheckMobi::Resources::Voice::Actions::Play.new
    @send_dtmf = CheckMobi::Resources::Voice::Actions::SendDTMF.new
    @wait_action = CheckMobi::Resources::Voice::Actions::SendDTMF.new
    @hangup_action = CheckMobi::Resources::Voice::Actions::Hangup.new
  end

  it 'should set default values when not specified' do
    @resource.events.must_equal []
    @resource.platform.must_equal CheckMobi::Configuration::DEFAULT_PLATFORM
  end

  it 'should set events as sent during initialization' do
    resource = CheckMobi::Resources::Voice::Call.new(events: [1])
    resource.events.must_equal [1]
  end

  it 'should set events after initialization' do
    @resource.events << {key: 'value'}
    @resource.events.must_equal [{key: 'value'}]
  end

  it 'should add speak event correctly' do
    @resource.events << @speak_action
    @resource.events.length.must_equal 1
    @resource.events.first.action.must_equal @speak_action.class.name.split('::').last.underscore!
  end

  it 'should add play event correctly' do
    @resource.events << @play_action
    @resource.events.length.must_equal 1
    @resource.events.first.action.must_equal @play_action.class.name.split('::').last.underscore!
  end

  it 'should add send_dtmf event correctly' do
    @resource.events << @send_dtmf
    @resource.events.length.must_equal 1
    @resource.events.first.action.must_equal @send_dtmf.class.name.split('::').last.underscore!
  end

  it 'should add hangup event correctly' do
    @resource.events << @hangup_action
    @resource.events.length.must_equal 1
    @resource.events.first.action.must_equal @hangup_action.class.name.split('::').last.underscore!
  end

  it 'should add wait event correctly' do
    @resource.events << @wait_action
    @resource.events.length.must_equal 1
    @resource.events.first.action.must_equal @wait_action.class.name.split('::').last.underscore!
  end

  it 'should add multiple events correctly' do
    @resource.events << @speak_action
    @resource.events.length.must_equal 1
    @resource.events << @play_action
    @resource.events.length.must_equal 2
    @resource.events << @send_dtmf
    @resource.events.length.must_equal 3
    @resource.events.concat [@hangup_action, @wait_action]
    @resource.events.length.must_equal 5
    @resource.events.each {|event| event.action.must_equal event.class.name.split('::').last.underscore!}
  end
end