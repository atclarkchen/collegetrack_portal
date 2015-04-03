require 'rails_helper'

describe User do

  describe 'find_for_google_oauth2' do

    it 'should find registered users when given a valid email' do
      valid_user = User.create!(:email => "fake@gmail.com", :password => "password")
      OmniAuth.config.add_mock(:google_oauth2, {
        :info => {
          :email => "fake@gmail.com"
        }
      })
      user = User.find_for_google_oauth2(OmniAuth.config.mock_auth[:google_oauth2])
      expect(user).to eq(valid_user)
    end

  end
end