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

end