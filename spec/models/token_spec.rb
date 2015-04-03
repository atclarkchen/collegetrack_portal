require 'rails_helper'

RSpec.describe Token, type: :model do

  before :each do
    @token = FactoryGirl.build(:token)
    ENV['CLIENT_ID'] = "client_id"
    ENV['CLIENT_SECRET'] = "client_secret"
  end

  describe "#to_params" do
    it 'returns hash to request new access token' do
      params = {'refresh_token' => @token.refresh_token,
                'client_id' => ENV['CLIENT_ID'],
                'client_secret' => ENV['CLIENT_SECRET'],
                'grant_type' => 'refresh_token'}

      expect(@token.to_params).to eq params
    end
  end

  describe '#expired?' do
    it 'checks if the current token expires' do
      token = FactoryGirl.build(:token, expires_at: Time.now - 10)
      expect(token.expired?).to eq true
    end
  end

  describe "#request_token_from_google" do
    it 'create URI object with Google oauth2 url' do
      
    end
  end

end