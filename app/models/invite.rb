class Invite < ApplicationRecord

  def self.find_email(username)
    service = GithubService.new
    result = service.get_user(username)
    return result
  end

end