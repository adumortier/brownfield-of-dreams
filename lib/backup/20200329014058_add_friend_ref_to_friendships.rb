class AddFriendRefToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_reference :friendships, :friend, foreign_key: true
    add_foreign_key :friendships, :friends
  end
end
