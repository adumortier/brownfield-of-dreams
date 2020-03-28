class Repository
  attr_reader :name, :link

  def initialize(info)
    @name = info[:name]
    @link = info[:html_url]
  end
end
