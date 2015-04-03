require 'spec_helper'

describe OmniauthCallbacksController do
  include Devise::TestHelpers

  describe 'google_oauth2' do
    
    before :each do
      #@user = double('fake user', :email => 'fake@gmail.com')
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end
    
    it 'should do something' do
      get :google_oauth2
      response.should be_redirect
      #User.should_receive(:find_for_google_oauth2).with(request.env["omniauth.auth"], current_user).and_return(@user)
      #expect(@user).to be_truthy
    end
  end

end