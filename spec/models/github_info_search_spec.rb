require 'rails_helper'

RSpec.describe GithubInfoSearch do 

  describe 'attributes' do 

    before(:each) do
      @token = ENV['GITHUB_USER1_TOKEN']
      @search = GithubInfoSearch.new(@token)
    end

    it {expect(@search).to be_an_instance_of(GithubInfoSearch)} 
    it {expect(@search).to have_attributes(token: @token)}

  end 

  describe 'methods' do

    before(:each) do
      @token = ENV['GITHUB_USER1_TOKEN']
      @search = GithubInfoSearch.new(@token)
    end

    it "returns repositories" do
      VCR.use_cassette('/github_info_search/returns_repositories') do
        @search.repositories.each do |repository| 
          expect(repository).to be_an_instance_of(Repository)
        end
      end
    end

    it "returns followers" do
      VCR.use_cassette('/github_info_search/returns_followers') do
        @search.followers.each do |follower| 
          expect(follower).to be_an_instance_of(Follower)
        end
      end
    end

    it "returns following" do
      VCR.use_cassette('/github_info_search/returns_following') do
        @search.following.each do |following| 
          expect(following).to be_an_instance_of(Following)
        end
      end
    end

  end 

end