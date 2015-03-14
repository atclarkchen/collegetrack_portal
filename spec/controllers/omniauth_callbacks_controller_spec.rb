require 'spec_helper'

describe Users::OmniauthCallbacksController do

  describe 'google_oauth2' do
    
    before :each do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end
    
    it 'should do something' do
      get "user/auth/failure"
      expect(response).to redirect_to root_path
    end
  end
end