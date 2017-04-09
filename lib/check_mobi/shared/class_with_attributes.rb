module ClassWithAttributes
  def self.included(base)
    base.extend ClassMethods
  end

  def attributes
    self.class.attributes
  end

  module ClassMethods

    def attr_accessor(*vars)
      @attributes ||= [:action]
      @attributes.concat vars
      super(*vars)
    end

    def attributes
      @attributes
    end
  end
end