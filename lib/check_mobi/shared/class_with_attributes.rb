module ClassWithAttributes
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def attributes(*vars)
      @attributes ||= []

      vars.uniq.each do |var|
        @attributes << {name: var, default: nil}
      end

      send :include, InstanceMethods unless included_modules.include?(InstanceMethods)
      attr_accessor *vars
    end

    def attribute(name, options={})
      @attributes ||= []

      @attributes << ({name: name, default: options[:default]})

      send :include, InstanceMethods unless included_modules.include?(InstanceMethods)
      attr_accessor name
    end

  end

  module InstanceMethods

    def attributes
      self.class.instance_variable_get(:@attributes).map{|e| e[:name]}
    end

    def initialize(options = {})
      attributes = (self.class.instance_variable_get(:@attributes) || []).map{|e| [e[:name], e[:default].dup]}

      attributes.each do |name, val|
          value = options.include?(name) ? options[name] : val
          instance_variable_set("@#{name}", value)
      end

      after_initialize
    end

    def to_hash
      h = {}
      attributes.each do |attr|
        value = send(attr)
        if value.respond_to?(:to_hash)
          h[attr] = value.to_hash
        elsif value.is_a? Array
          values = []
          value.each do |val|
            if value.respond_to?(:to_hash)
              values << val.to_h
            else
              values << val
            end
          end
          h[attr] = values
        else
          h[attr] = value
        end
      end

      return h
    end

  end
end