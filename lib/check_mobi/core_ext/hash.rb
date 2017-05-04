class Hash
  def cm_symbolize_keys
    self.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  end

  def cm_stringify_keys
    super if defined? Rails
    self.inject({}){|memo,(k,v)| memo[k.to_s] = v; memo}
  end
end
