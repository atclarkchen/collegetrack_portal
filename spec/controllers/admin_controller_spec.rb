require 'rails_helper'

describe AdminController do

  before :each do
    login_admin
  end

  describe 'index' do
    it 'should index' do
      get :index
      expect(response).to render_template(:index)
    end
  end 

  describe 'new' do
    it 'should make new' do
      get :new, :user => {:name => "Michael Jackson", :email => "BeatitandTweetit@thriller.com", :role => "Admin", :password => "password"}
      expect(response).to redirect_to admin_path
    end
  end   

  describe 'destroy' do
    it 'should destroy' do
      new_user  = User.new({:name => "Michael Jackson", :email => "BeatitandTweetit@thriller.com", :role => "Admin", :password => "password"})
        new_user.save!
        expect{ 
              delete :destroy, :user => new_user
        }.to change(User, :count).by(-1)
        expect(response).to redirect_to admin_path
    end
  end    

  describe 'save_password' do
    it 'should reset' do
        post :save_password, :confirm_password => {:confirm_password => "asdfasdf"}, :password => {:password => "asdfasdf"}, :token => {:token => "VK1tbyhhTHNYipfSucswcCL4"}
        expect(response).to redirect_to root_path
    end
  end

  describe 'reset salesforce' do
    it 'should render' do
        get :reset_salesforce
        expect(response).to render_template("reset_salesforce")
    end
  end


end