require 'helper'

describe CheckMobi::Resources::Voice::Actions::SendDTMF do
  describe 'SendDTMF functions' do
    before do
      CheckMobi.configure do |c|
        c.api_key = ENV['API_KEY']
      end

      @resource = CheckMobi::Resources::Voice::Call.new(
          to: ENV['PHONE_NUMBER'],
          from: ENV['PHONE_NUMBER']
      )

      @send_dtmf = CheckMobi::Resources::Voice::Actions::SendDTMF.new
    end

    it 'should set default values' do
      @send_dtmf.action.must_equal 'send_dtmf'
      @send_dtmf.async.must_equal true
    end

    it 'should not allow setting action name' do
      @send_dtmf.respond_to?(:action=).must_equal false
    end
  end


end