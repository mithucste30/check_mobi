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

    it 'should add send_dtmf event correctly' do
      @resource.events << @send_dtmf
      @resource.events.length.must_equal 1
      @resource.events.first.action.must_equal @send_dtmf.class.name.split('::').last.underscore!
    end

    it 'should build hashes correctly' do
      @resource.events << @send_dtmf
      hash = @resource.to_hash
      hash.keys.must_include(:events)
      hash[:events].must_be_instance_of Array
      hash[:events].first.must_be_instance_of Hash
      hash[:events].first[:action].must_equal @send_dtmf.class.name.split('::').last.underscore!
    end

    it 'should fail without digits' do
      @resource.events << @send_dtmf
      response = @resource.perform
      response.status_code.must_equal '400'
      response.code.must_equal 10
    end

    it 'should pass with invalid digits' do
      @send_dtmf.digits = 'sdefrt'
      @resource.events << @send_dtmf
      response = @resource.perform
      response.status_code.must_equal '200'
    end

    it 'should pass with digits' do
      @send_dtmf.digits = '*1234#'
      @resource.events << @send_dtmf
      response = @resource.perform
      response.status_code.must_equal '200'
    end
  end


end