class Hash
  def symbolize_keys
    self.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  end

  def stringify_keys
    self.inject({}){|memo,(k,v)| memo[k.to_s] = v; memo}
  end
end
