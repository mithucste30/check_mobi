module CheckMobi
  module Service
    class Sms
      include CheckMobi::Connection

      attr_accessor :to, :text, :callback_url, :platform, :rel_path, :method

      def initialize(options={})
        @to = options[:to]
        @text = options[:text]
        @platform = 'web'
        @rel_path = nil
        @method = :post
      end

      def send
        self.rel_path = '/sms/send'
        req = Net::HTTP::Post.new(uri.path)
        req.body = {to: to, text: text}.to_json
        fetch(req)
      end

      def get_details(id)
        self.rel_path = "/call/#{id}"
        req = Net::HTTP::Get.new(uri.path)
        fetch(req)
      end

    end
  end #service
end # checkmobi
