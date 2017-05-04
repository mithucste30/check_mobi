class String
  def cm_underscore!
    self.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase!
  end

  def cm_underscore
    dup.cm_underscore!
  end
end
