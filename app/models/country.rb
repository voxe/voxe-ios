class Country
  PROPERTIES = [:name, :namespace]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(hsh={})
    hsh.each do |key, value|
      if PROPERTIES.member? key.to_sym
        self.send "#{key.to_s}=", value
      end
    end
  end
  
end
