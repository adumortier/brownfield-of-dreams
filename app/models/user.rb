class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships 
  has_many :friends, through: :friendships
  
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

  def username
    search = GithubInfoSearch.new(token)
    return search.username
  end

  def potential_friends
    following_followers = (self.list_following.map(&:name) + self.list_followers.map(&:name)).uniq
    users_username = User.with_token.map do |user|
      user.username
    end
    result = User.with_token.reduce({}) do |acc,user|
      if following_followers.include?(user.username)
        acc[user.username] = user.id
      end
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

  def self.with_token
    @users ||= User.where.not(token: [nil,""])
  end

  def list_friends
    friends_id = Friendship.where(user_id: self.id).pluck(:friend_id)
    return User.where(id: friends_id)
  end

end
