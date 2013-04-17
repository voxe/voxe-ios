class Candidacy
  attr_accessor :name, :namespace

  def initialize(hsh = {})
    @namespace = hsh['namespace']
    candidate = hsh['candidates'][0]
    @name = "#{candidate['firstName']} #{candidate['lastName']}"
  end
end
