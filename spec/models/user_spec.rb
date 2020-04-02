require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'relationships' do
    it { should have_many :friendships }
    it { should have_many(:friends).through(:friendships) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'methods' do
    before(:each) do
      user1_params = { email: 'dumortier.alexis@gmail.com', first_name: 'Alexis', last_name: 'Dumortier', password: 'temp', role: 0, token: ENV['GITHUB_USER1_TOKEN'] }
      @user1 = User.create!(user1_params)
      user2_params = { email: 'paul@gmail.com', first_name: 'Paul', last_name: 'Debevec', password: 'temp', role: 0, token: ENV['GITHUB_USER2_TOKEN'] }
      @user2 = User.create!(user2_params)
    end

    it 'returns repositories' do
      VCR.use_cassette('/user/returns_repositories') do
        @user1.list_repositories.each do |repository|
          expect(repository).to be_an_instance_of(Repository)
        end
      end
    end

    it 'returns followers' do
      VCR.use_cassette('/user/returns_followers') do
        @user1.list_followers.each do |follower|
          expect(follower).to be_an_instance_of(Follower)
        end
      end
    end

    it 'returns following' do
      VCR.use_cassette('/user/returns_following') do
        @user1.list_following.each do |following|
          expect(following).to be_an_instance_of(Following)
        end
      end
    end

    it 'returns following' do
      VCR.use_cassette('/user/returns_username') do
        expect(@user1.username).to eq('adumortier')
      end
    end

    xit 'returns potential_friends' do
      VCR.use_cassette('/user/returns_potential_friends') do
        expect(@user1.potential_friends).to eq({ 'PaulDebevec' => @user2.id })
      end
    end

    it 'returns friends' do
      VCR.use_cassette('/user/returns_friends') do
        user3_params = { email: 'maria@gmail.com', first_name: 'Maria', last_name: 'Ronauli', password: 'temp', role: 0, token: 'asdasdasdasd' }
        @user3 = User.create!(user3_params)
        Friendship.create({ user_id: @user1.id, friend_id: @user2.id })
        expect(@user1.list_friends).to eq([@user2])
      end
    end
  end
end
