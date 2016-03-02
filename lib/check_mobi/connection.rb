module CheckMobi
  module Connection
    require 'net/http'
    require 'json'
    require 'ostruct'

    # def self.extended(base)
    #   base.extend self
    # end

    def fetch(req)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req['Content-Type']= 'application/json'
      req['Authorization']= CheckMobi.api_key
      return http.request(req)
    end

    def uri
      URI(CheckMobi.endpoint + rel_path)
    end
  end
end
