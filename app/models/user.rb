class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def list_repositories
    search = GithubInfoSearch.new(token)
    return search.repositories
  end

  def list_followers
    search = GithubInfoSearch.new(token)
    return search.followers
  end

  def list_following
    search = GithubInfoSearch.new(token)
    return search.following
  end

end
