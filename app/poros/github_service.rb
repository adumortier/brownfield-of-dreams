class GithubService

  attr_reader :user_data, :user_followers, :user_following, :user_account

  def user_data(token)
    @user_data ||= get_json("/user/repos?access_token=#{token}")
  end

  def user_followers(token)
    @user_followers ||= get_json("/user/followers?access_token=#{token}")
  end

  def user_following(token)
    @user_following ||= get_json("/user/following?access_token=#{token}")
  end

  def user_account(token)
    @user_account ||= get_json("/user?access_token=#{token}")
  end

  def get_user(user_name)
    @user_info = get_json("/users/#{user_name}")
  end

  def get_public_events(user_name)
    @user_events = get_json("/users/#{user_name}/events/public")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body)
  end

  def conn
    Faraday.new(url: "https://api.github.com") 
  end

end
