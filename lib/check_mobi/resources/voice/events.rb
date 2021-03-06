require_relative '../../shared/class_with_attributes'

module CheckMobi
  module Resources
    module Voice
      class Events
        include ClassWithAttributes

        readonly_attributes :action

        def to_hash
          super.merge({action: action})
        end

        private

        def after_initialize # overridden by subclasses
          @action = self.class.name.split('::').last.cm_underscore!
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
