require 'rails_helper'

describe SalesforceController do

  before :each do
    login_admin
  end

  describe 'save_password' do
    it 'should reset' do
        SalesforceClient.create!(:password => "default", :security_token => "default")
        post :save_password, :confirm_password => {:confirm_password => "asdfasdf"}, :password => {:password => "asdfasdf"}, :token => {:token => "VK1tbyhhTHNYipfSucswcCL4"}
        expect(response).to redirect_to root_path
    end
  end

  describe 'reset salesforce' do
    it 'should render' do
        SalesforceClient.create!(:password => "default", :security_token => "default")
        get :reset_salesforce
        expect(response).to render_template("reset_salesforce")
    end
  end

end