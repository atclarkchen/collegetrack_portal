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
end
