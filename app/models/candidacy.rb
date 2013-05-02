class Candidacy
  attr_accessor :id, :name, :namespace

  def initialize(hsh = {})
    @id = hsh['id']
    @namespace = hsh['namespace']
    candidate = hsh['candidates'][0]
    @name = "#{candidate['firstName']} #{candidate['lastName']}"
  end
end
