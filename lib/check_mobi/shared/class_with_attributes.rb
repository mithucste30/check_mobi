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

    def readonly_attributes(*vars)
      @attributes ||= []

      vars.uniq.each do |var|
        @attributes << {name: var, default: nil}
      end

      send :include, InstanceMethods unless included_modules.include?(InstanceMethods)
      attr_reader *vars
    end

    def attribute(name, options={})
      @attributes ||= []

      @attributes << ({name: name, default: options[:default]})

      send :include, InstanceMethods unless included_modules.include?(InstanceMethods)
      attr_accessor name
    end

    def readonly_attribute(name, options={})
      @attributes ||= []

      @attributes << ({name: name, default: options[:default]})

      send :include, InstanceMethods unless included_modules.include?(InstanceMethods)
      attr_reader name
    end

  end

  module InstanceMethods

    def attributes
      self.class.instance_variable_get(:@attributes).map{|e| e[:name]}
    end

    def initialize(options = {})
      attributes = (self.class.instance_variable_get(:@attributes) || []).map{|e| [e[:name], e[:default].dup]}

      attributes.each do |name, val|
        if respond_to?("#{name}=") and options.include?(name)
          value =  options[name]
        else
          value = val
        end

        instance_variable_set("@#{name}", value)
      end

      after_initialize if respond_to?(:after_initialize, true)
    end

    def update_attributes(options= {})
      valid_options = options.select { |k,v| attributes.map(&:to_s).include?(k.to_s) }
      valid_options.each {|k,v| public_send("#{k}=", v) if respond_to?("#{k}=")}
    end

    def to_hash
      h = {}
      attributes.each do |attr|
        value = public_send(attr)
        if value.is_a? Array
          values = []
          value.each do |val|
            if val.respond_to?(:to_hash)
              values << val.to_hash
            else
              values << val
            end
          end
          h[attr] = values
        elsif value.respond_to?(:to_hash)
          h[attr] = value.to_hash
        else
          h[attr] = value
        end
      end

      return h
    end

  end
end