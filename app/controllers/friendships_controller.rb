class FriendshipsController < ApplicationController
  def create
    Friendship.create({ user_id: params['user_id'], friend_id: params['friend_id'] })
    Friendship.create({ user_id: params['friend_id'], friend_id: params['user_id'] })
    redirect_to '/dashboard'
  end
end
