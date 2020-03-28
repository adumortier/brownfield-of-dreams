class GithubInfoSearch 

  attr_reader :token

  def initialize(token)
    @token = token
  end

  def repositories
    service = GithubService.new
    repositories = service.user_data(@token).map do |repo_params|
      Repository.new({name: repo_params["name"], link: repo_params["html_url"]})
    end
    repositories[0..4]
  end

  def followers
    service = GithubService.new
    followers = service.user_followers(@token).map do |follower_params|
      Follower.new({login: follower_params["login"], url: follower_params["url"]})
    end
    followers
  end

  def following
    service = GithubService.new
    following = service.user_following(@token).map do |following_params|
      Following.new({login: following_params["login"], url: following_params["url"]})
    end
    following
  end

end
