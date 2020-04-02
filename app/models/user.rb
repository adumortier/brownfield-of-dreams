class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: %i[default admin]
  enum status: %i[inactive active]

  has_secure_password

  before_create :confirmation_token

  attr_reader :list_following, :list_followers, :list_repositories, :search

  def list_repositories
    @search ||= GithubInfoSearch.new(token)
    @list_repositories = search.repositories
    @list_repositories
  end

  def list_followers
    @search ||= GithubInfoSearch.new(token)
    @list_followers ||= search.followers
    @list_followers
  end

  def list_following
    @search ||= GithubInfoSearch.new(token)
    @list_following ||= search.following
    @list_following
  end

  def username
    @search ||= GithubInfoSearch.new(token)
    search.username
  end

  def potential_friends
    following_followers = (list_following.map(&:name) + list_followers.map(&:name)).uniq
    users_username = User.with_token.map do |user|
      user.username
    end
    result = User.with_token.reduce({}) do |acc, user|
      acc[user.username] = user.id if following_followers.include?(user.username)
      acc
    end
    result
  end

  #   current_username = self.username
  #   @potential_friends ||= User.with_token.find_all do |user|
  #     user.list_following.map(&:name).include?(current_username) || user.list_followers.map(&:name).include?(current_username)
  #   end
  #   result = @potential_friends.reduce({}) do |acc, friend|
  #     acc[friend.username] = friend.id
  #     acc
  #   end
  #   return result
  # end

  def list_bookmarks
    Video.select('videos.*, tutorials.id as tutorial_id, user_videos.user_id')
         .joins(:tutorial)
         .joins(:user_videos)
         .where(user_videos: { user_id: id })
         .order(:tutorial_id)
         .order(:position)
  end

  def self.with_token
    @users ||= User.where.not(token: [nil, ''])
  end

  def list_friends
    friends_id = Friendship.where(user_id: id).pluck(:friend_id)
    User.where(id: friends_id)
  end

  def activate
    self.status = 1
    self.confirm_token = nil
    save!(validate: false)
  end

  private

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end
end
