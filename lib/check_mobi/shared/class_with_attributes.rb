module ClassWithAttributes
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def attributes(*vars)
      @attributes ||= []
      @attributes.concat(vars)
      send :include, InstanceMethods
      attr_accessor *vars
    end

  end

  module InstanceMethods

    def attributes
      self.class.attributes
    end

    def initialize(*args)

      if self.class.instance_variable_defined?(:@attributes)
        self.class.instance_variable_get(:@attributes).each do |attr|
          instance_variable_set("@#{attr}", args[0][attr])
        end
      end

      after_initialize

    end

  end
end