class Election
  PROPERTIES = [:id, :name, :candidacies, :tags, :published, :country]
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

  def tags=(tags_attrs)
    @tags = tags_attrs.map { |attributes| Tags.new(attributes) }
  end

  def country=(country_hsh={})
    @country = Country.new(country_hsh)
  end

end
