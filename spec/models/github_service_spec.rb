require 'rails_helper'

RSpec.describe GithubService do
  describe 'attributes' do
    before(:each) do
      @service = GithubService.new
    end

    it { expect(@service).to be_an_instance_of(GithubService) }
  end

  describe 'methods' do
    before(:each) do
      @service = GithubService.new
    end

    it '#user_data' do
      VCR.use_cassette('/github_service/returns_repositories') do
        token = ENV['GITHUB_USER1_TOKEN']
        response = @service.user_data(token)
        response.each do |resp|
          expect(resp.has_key?('name')).to eq(true)
          expect(resp.has_key?('html_url')).to eq(true)
        end
      end
    end

    it '#user_followers' do
      VCR.use_cassette('/github_service/returns_followers') do
        token = ENV['GITHUB_USER1_TOKEN']
        response = @service.user_followers(token)
        response.each do |resp|
          expect(resp.has_key?('login')).to eq(true)
          expect(resp.has_key?('url')).to eq(true)
        end
      end
    end

    it '#user_following' do
      VCR.use_cassette('/github_service/returns_following') do
        token = ENV['GITHUB_USER1_TOKEN']
        response = @service.user_following(token)
        response.each do |resp|
          expect(resp.has_key?('login')).to eq(true)
          expect(resp.has_key?('url')).to eq(true)
        end
      end
    end

    it '#user_account' do
      VCR.use_cassette('/github_service/returns_user_account') do
        token = ENV['GITHUB_USER1_TOKEN']
        response = @service.user_account(token)
        expect(response.has_key?('login')).to eq(true)
      end
    end
  end
end
