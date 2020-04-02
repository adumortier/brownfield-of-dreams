class Invite < ApplicationRecord
  def self.find_email(username)
    service = GithubService.new
    result = service.get_user(username)
    result
  end
end
