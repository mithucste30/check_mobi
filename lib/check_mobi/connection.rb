require 'faraday'

module CheckMobi
  module Connection

    def build
      uri = URI('https://api.checkmobi.com/v1/sms/send')
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.path)
      req['Content-Type']='application/json'
      req['Authorization']='key'
      req.body = '{"to":"+8801911255016", "text":"hi man"}'
      http.request(req)
    end
  end
end
