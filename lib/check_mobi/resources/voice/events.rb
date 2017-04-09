module CheckMobi
  module Resources
    module Voice
      class Events

        attr_reader :action

        def self.attr_accessor(*vars)
          @attributes ||= [:action]
          @attributes.concat vars
          super(*vars)
        end

        def self.attributes
          @attributes
        end

        def attributes
          self.class.attributes
        end

        private

        def initialize(params = {})
          @action = self.class.name.split('::').last.underscore!
          params.each {|k,v| public_send("#{k}=",v)}
          after_initialize
        end

        def after_initialize # overridden by subclasses

        end
      end
    end
  end
end

# class << self
#   attr_reader :required_fields
#
#   def mandatory_fields(*args)
#     @required_fields = []
#     args.each {|field| @required_fields << field}
#   end
# end