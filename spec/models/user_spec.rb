require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'methods' do

    before(:each) do
      user1_params = {email: 'dumortier.alexis@gmail.com', first_name: 'Alexis', last_name: 'Dumortier', password_digest: 'temp', role: 0, token: ENV['GITHUB_USER1_TOKEN']}
      @user1 = User.create(user1_params)
    end

    it "returns repositories" do
      VCR.use_cassette('/user/returns_repositories') do
        @user1.list_repositories.each do |repository| 
          expect(repository).to be_an_instance_of(Repository)
        end
      end
    end

    it "returns followers" do
      VCR.use_cassette('/user/returns_followers') do
        @user1.list_followers.each do |follower| 
          expect(follower).to be_an_instance_of(Follower)
        end
      end
    end

    it "returns following" do
      VCR.use_cassette('/user/returns_following') do
        @user1.list_following.each do |following| 
          expect(following).to be_an_instance_of(Following)
        end
      end
    end

  end 
    
end
