require 'rails_helper'

describe Users::OmniauthCallbacksController do

  describe 'google_oauth2' do
    
    context 'happy path' do
      before :each do
        @user = User.create(:email => "fake@gmail.com", :password => "password")
        google_hash
        get :google_oauth2
      end

      it 'sets the user' do
        expect(assigns(:user)).to eq(@user)
      end
    
      it 'redirects to email page' do
        expect(response).to redirect_to email_index_path   
      end
    end

    context 'invalid credentials' do
      before :each do
        google_hash
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        get :google_oauth2
      end

      it 'redirects to the root_path' do
        expect(response).to redirect_to root_path
      end
    end
  end
end