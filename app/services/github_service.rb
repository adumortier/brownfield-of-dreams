class GithubService

  def user_data(token)
    response = conn.get("/user/repos?access_token=#{token}")
    JSON.parse(response.body)
  end

  private

  def conn
    Faraday.new(url: 'https://api.github.com')
  end
end
