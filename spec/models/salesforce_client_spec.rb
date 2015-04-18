require 'rails_helper'

describe SalesforceClient do
  
  before :each do
    @client = SalesforceClient.create!(:password => "default", :security_token => "default")
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
    it "should the Restforce client" do
      restforce = @client.update_client
      expect(restforce.password).to eq(SalesforceClient.password)
      expect(restforce.security_token).to eq(SalesforceClient.security_token)
    end
  end

  describe "change password" do
    it "should update the SalesforceClient password and security security token" do
      new_restforce = @client.change_password("updated password", "updated token")
      expect(new_restforce.password).to eq(SalesforceClient.password)
      expect(new_restforce.security_token).to eq(SalesforceClient.security_token)
    end
  end

  describe "connect_salesforce" do
    it "should successfully authenticate to Salesforce" do
      response = @client.connect_salesforce
      expect(response).to be_a Restforce::Mash
    end
  end
end
