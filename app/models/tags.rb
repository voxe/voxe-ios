class Tags
  attr_accessor :id, :name, :namespace, :iconURL

  def initialize(hsh = {})
  	@id = hsh['id']
    @namespace = hsh['namespace']
    @name = hsh['name']
    icon = hsh['icon']
    @iconURL = icon['prefix'] + icon['sizes'][1].to_s + icon['name']
  end
end
