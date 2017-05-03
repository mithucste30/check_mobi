require 'helper'
require 'json'

describe CheckMobi::Client do
	let(:form_data) { {'sample_data': 1} }

  describe 'In Common' do
    before do
      CheckMobi.configure do |c|
        c.content_type = 'json'
        c.accept_type = 'json'
        c.api_key = '1234567'
      end

      @client = CheckMobi::Client.new()
    end

    after do
      CheckMobi.reset
    end

    it 'should have valid headers' do
      @client.headers['Content-Type'].must_equal CheckMobi.content_type
      @client.headers['Accept'].must_equal CheckMobi.accept_type
      @client.headers['Authorization'].must_equal CheckMobi.api_key
    end
  end

	describe 'On HTTP GET' do

		before do
    		@client = CheckMobi::Client.new(http_method: :get)
    		@request = @client.request
    end

  	it 'should return instance of net/http/get instance' do
  			@request.must_be_instance_of Net::HTTP::Get
  	end

  	it 'wont accept/return form_data' do
			  @client.send(:set_body, form_data)
			  @request.body.must_equal nil
    end

  end

  describe "On HTTP POST" do

		before do
			@client = CheckMobi::Client.new(http_method: :post)
			@request = @client.request
		end

		it "should return instance of net/http/get instance" do
  			@request.must_be_instance_of Net::HTTP::Post
  		end

		it "should accept/return form_data" do
			@client.send(:set_body, form_data)
      JSON.parse(@request.body).symbolize_keys.must_equal form_data
    end

  end
end
