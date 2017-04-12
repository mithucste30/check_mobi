module CheckMobi
  class Response

    attr_accessor :status, :body, :is_successful, :errors

    def initialize
      @errors = []
    end
  end
end