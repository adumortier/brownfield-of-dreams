class Repository

  attr_reader :name, :link

  def initialize(info)
    @name = info[:name]
    @link = info[:link]
  end
  
end