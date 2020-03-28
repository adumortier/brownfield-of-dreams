class GithubInfoSearch

  def initialize(token)
    @token = token
  end

  def repositories
    service = GithubService.new
    repositories = service.user_data(@token).map do |repo_params|
      Repository.new({name: repo_params['name'], html_url: repo_params['html_url']})
    end
    repositories[0..4]
  end
end
