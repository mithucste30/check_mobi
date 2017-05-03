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

end