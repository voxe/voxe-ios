class Election
  PROPERTIES = [:id, :name, :candidacies]
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

  def candidacies=(candidacies_attrs)
    @candidacies = candidacies_attrs.map { |attributes| Candidacy.new(attributes) }
  end
end
