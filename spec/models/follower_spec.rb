require 'rails_helper'

RSpec.describe Follower do
  describe 'class attributes' do
    before(:each) do
      info = { login: 'a nice follower', url: 'http://wwww.myfollower.com' }
      @follower = Follower.new(info)
    end

    it { expect(@follower).to be_an_instance_of(Follower) }
    it { expect(@follower).to have_attributes(name: 'a nice follower', link: 'http://wwww.myfollower.com') }
  end
end
