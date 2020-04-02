class GithubInfoSearch 

  attr_reader :token, :repositories, :followers, :following

  def initialize(token)
    @token = token
    @service = GithubService.new
  end

  def repositories
    @repositories ||= @service.user_data(@token).map do |repo_params|
      Repository.new({name: repo_params["name"], link: repo_params["html_url"]})
    end
    @repositories[0..4]
  end

  def followers
    @followers ||= @service.user_followers(@token).map do |follower_params|
      Follower.new({login: follower_params["login"], url: follower_params["html_url"]})
    end
    @followers
  end

  def following
    @following ||= @service.user_following(@token).map do |following_params|
      Following.new({login: following_params["login"], url: following_params["html_url"]})
    end
    @following
  end

  def username
    user_info = @service.user_account(@token)
    return user_info["login"]
  end

end
