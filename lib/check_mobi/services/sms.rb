module CheckMobi
  module Service
    class Sms
      REL_PATH = '/sms'

      def initialize(options={})
        @to = options[:to]
        @text = options[:text]
        @callback_url = options[:callback_url]
        @platform = 'web'
        @rel_path = REL_PATH
        @method = :post
      end

      def send
        self.rel_path = rel_path.concat('/send')
        
      end
    end
  end #service
end # checkmobi
