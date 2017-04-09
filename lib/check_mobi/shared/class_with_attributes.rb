module ClassWithAttributes
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def attr_accessor(*vars)
      @attributes ||= [:action]
      @attributes.concat vars
      send :include, InstanceMethods
      super(*vars)
    end

    def attributes
      @attributes
    end
  end

  module InstanceMethods

    def attributes
      self.class.attributes
    end
  end
end