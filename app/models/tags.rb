class Tags
  attr_accessor :id, :name, :namespace

  def initialize(hsh = {})
  	@id = hsh['id']
    @namespace = hsh['namespace']
    @name = hsh['name'] 
  end
end
