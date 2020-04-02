class Follower
  attr_reader :name, :link

  def initialize(info)
    @name = info[:login]
    @link = info[:url]
  end
end
