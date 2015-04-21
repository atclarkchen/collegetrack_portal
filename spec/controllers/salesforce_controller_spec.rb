require 'rails_helper'

describe SalesforceController do

  before :each do
    login_admin
  end

  describe 'save_password' do
    it 'should redirect' do
        post :save_password, :confirm_password => {:confirm_password => "asdfasdf"}, :password => {:password => "asdfasdf"}, :token => {:token => "token"}
        expect(response).to redirect_to root_path
    end

    it 'should update the password' do
      post :save_password, :confirm_password => {:confirm_password => "asdfasdf"}, :password => {:password => "asdfasdf"}, :token => {:token => "token"}
      expect(ENV['SALESFORCE_PASSWORD']).to eq("asdfasdf")
      expect(ENV['SALESFORCE_SECURITY_TOKEN']).to eq("token")
    end
  end

  describe 'reset salesforce' do
    it 'should render' do
        get :reset_salesforce
        expect(response).to render_template("reset_salesforce")
    end
  end

end