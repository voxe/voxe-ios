class Candidacy
  attr_accessor :id, :name, :namespace, :mediumPhotoURL

  def initialize(hsh = {})
    @id = hsh['id']
    @namespace = hsh['namespace']
    candidate = hsh['candidates'][0]
    @name = "#{candidate['firstName']} #{candidate['lastName']}"
    @mediumPhotoURL = "#{candidate['photo']['sizes']['medium']['url']}"
  end
end
