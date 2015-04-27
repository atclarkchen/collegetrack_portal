require 'rails_helper'

describe SalesforceController do

  before :each do
    login_admin
  end

  context 'Salesforce password is up to date' do

    describe 'save password' do
      it 'should redirect to login page' do
        post :save_password, :confirm_password => {:confirm_password => "asdfasdf"}, :password => {:password => "asdfasdf"}, :token => {:token => "token"}
        expect(response).to redirect_to root_path
      end

      it 'should not modify the Salesforce password or token' do
        post :save_password, :confirm_password => {:confirm_password => "asdfasdf"}, :password => {:password => "asdfasdf"}, :token => {:token => "token"}
        expect(ENV['SALESFORCE_PASSWORD']).to_not eq("asdfasdf")
        expect(ENV['SALESFORCE_SECURITY_TOKEN']).to_not eq("token")
      end
    end

    describe 'reset salesforce' do
      it 'should redirect to email page' do
          get :reset_salesforce
          expect(response).to redirect_to email_index_path
      end
    end
  end

  context 'Salesforce password is outdated' do
    
    before :each do
      ENV['SALESFORCE_PASSWORD'] = 'outdated'
    end

    describe 'save_password' do
      it 'should redirect to login page' do
          post :save_password, :confirm_password => {:confirm_password => "asdfasdf"}, :password => {:password => "asdfasdf"}, :token => {:token => "token"}
          expect(response).to redirect_to root_path
      end

      it 'should update the Salesforce password' do
        post :save_password, :confirm_password => {:confirm_password => "asdfasdf"}, :password => {:password => "asdfasdf"}, :token => {:token => "token"}
        expect(ENV['SALESFORCE_PASSWORD']).to eq("asdfasdf")
        expect(ENV['SALESFORCE_SECURITY_TOKEN']).to eq("token")
      end
    end

    describe 'reset salesforce' do
      it 'should render the reset Salesforce page' do
          get :reset_salesforce
          expect(response).to render_template(:reset_salesforce)
      end
    end
  end
end