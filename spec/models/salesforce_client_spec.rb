require 'rails_helper'

describe SalesforceClient do
  
  before :each do
    @client = SalesforceClient.create!(:password => "default", :security_token => "default")
    @password = @client.password
    @token = @client.security_token
  end

  describe "self.password" do
    it "should return the SalesforceClient password" do
      expect(@client.password).to eq(SalesforceClient.password)
    end
  end

  describe "self.security_token" do
    it "should return the SalesforceClient security token" do
      expect(@client.security_token).to eq(SalesforceClient.security_token)
    end
  end

  describe "update_client" do
    it "should the update Restforce client" do
      restforce = @client.update_client
      expect(restforce).to eq(SalesforceClient.client)
    end
  end

  describe "change password" do
    it "should update the SalesforceClient password and security security token" do
      @client.change_password("new", "new")
      expect(SalesforceClient.password).to eq("new")
      expect(SalesforceClient.security_token).to eq("new")
    end
  end
end