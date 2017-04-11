require 'helper'

describe CheckMobi::Client do
	let(:form_data) { {sample_data: 1} }

	describe "On HTTP GET" do

		before do
    		@client = CheckMobi::Client.new(http_method: :get)
    		@request = @client.request
  		end

  		it "should return instance of net/http/get instance" do
  			@request.must_be_instance_of Net::HTTP::Get
  		end

  		it "won't accept/return form_data" do
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
			@request.body.must_equal URI.encode_www_form(form_data)
		end
    end
end