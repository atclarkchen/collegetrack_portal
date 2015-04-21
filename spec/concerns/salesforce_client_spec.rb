require 'rails_helper'

module TestTemps
  class SalesforceClientDouble
    include SalesforceClient
  end
end

describe SalesforceClient do
  
  before :each do
    @client = Restforce.new :username => "default", 
      :password => "default", 
      :security_token => "default", 
      :client_id => "default", 
      :client_secret => 'default'
  end

  describe "change password" do
    it "should change the Restforce password and security token" do
      new_password = "updated"
      new_token = "updated"
      new_restforce = change_password(new_password, new_token)
      expect(new_restforce.password).to eq(new_password)
      expect(new_restforce.security_token).to eq(new_token)
    end

    it "should change the environment" do
      change_password("updated", "updated")
      expect(ENV['SALESFORCE_PASSWORD']).to eq("updated")
      expect(ENV['SALESFORCE_SECURITY_TOKEN']).to eq("updated")
    end
  end
end