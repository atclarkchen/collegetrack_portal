require 'rails_helper'

describe SalesforceClient do
  
  before :each do
    ENV.stub(:[]).with("SALESFORCE_PASSWORD").and_return("asdf")
    ENV.stub(:[]).with("SALESFORCE_SECURITY_TOKEN").and_return("asdf")
    @client = Restforce.new :password => "default", :security_token => "default"
    @password = @client.password
    @security_token = @client.security_token
  end

  describe "update_client" do
    it "should update the Restforce client" do
      restforce = @client.update_client
      expect(restforce.password).to eq(ENV['SALESFORCE_PASSWORD'])
      expect(restforce.security_token).to eq(ENV['SALESFORCE_SECURITY_TOKEN'])
    end
  end

  describe "change password" do
    it "should change the Restforce password and security token" do
      new_password = "updated password"
      new_token = "updated token"
      new_restforce = @client.change_password(new_password, new_token)
      expect(new_restforce.password).to eq(new_password)
      expect(new_restforce.security_token).to eq(new_token)
    end

    it "should change the environment" do
      @client.change_password("updated", "updated")
      expect(ENV['SALESFORCE_PASSWORD']).to eq("updated")
      expect(ENV['SALESFORCE_SECURITY_TOKEN']).to eq("updated")
    end
  end
end