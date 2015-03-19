require 'rails_helper'

describe Users::OmniauthCallbacksController do

  describe 'google_oauth2' do
    
    context 'when logging in with a valid email' do
      before :each do
        google_hash
      end

      it 'should verify if email belongs to a registered user' do
        expect(User).to receive(:find_for_google_oauth2).with(request.env["omniauth.auth"], nil)
        get :google_oauth2
      end
    
      it 'should redirect to the email page' do
        user = double('user', :email => 'fake@gmail.com')
        User.stub(:find_for_google_oauth2).and_return(user)
        get :google_oauth2
        response.should redirect_to email_index_path
      end
    end

    context 'when logging with with an invalid email' do
      before :each do
        google_hash
        #oauth_hash = request.env["omniauth.auth"]
        #request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        #get :google_oauth2
      end

      it 'should redirect to the login page' do
        @user = double('user')
        User.stub(:find_for_google_oauth2).and_return(@user)
        get :google_oauth2
        response.should redirect_to root_path
      end
    end
  end
end