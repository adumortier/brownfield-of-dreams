class GithubService

  def user_data(token)
    response = conn.get("/user/repos?access_token=#{token}")
    JSON.parse(response.body)
  end

  def user_followers(token)
    response = conn.get("/user/followers?access_token=#{token}")
    JSON.parse(response.body)
  end

  def user_following(token)
    response = conn.get("/user/following?access_token=#{token}")
    JSON.parse(response.body)
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") 
  end

end
