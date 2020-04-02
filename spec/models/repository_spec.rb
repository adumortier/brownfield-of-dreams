require 'rails_helper'

RSpec.describe Repository do 

  describe 'class attributes' do 

    before(:each) do
      info = {name: "a nice repo", link: "http://wwww.myrepo.com"}
      @repository = Repository.new(info)
    end

    it {expect(@repository).to be_an_instance_of(Repository)} 
    it {expect(@repository).to have_attributes(name: "a nice repo", link: "http://wwww.myrepo.com")}

  end 

end