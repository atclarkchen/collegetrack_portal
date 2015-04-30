require 'rails_helper'

describe User do

  describe 'find_for_google_oauth2' do

    it 'should find registered users when given a valid email' do
      valid_user = User.create!(:email => "fake@gmail.com", :password => "password")
      OmniAuth.config.add_mock(:google_oauth2, {
        :info => {
          :email => "fake@gmail.com"
        }
      })
      user = User.find_for_google_oauth2(OmniAuth.config.mock_auth[:google_oauth2])
      expect(user).to eq(valid_user)
    end

  end

  describe '#delete_draft' do

    let(:user)  { User.create(email: "test@gmail.com", password: "1234") }
    let(:draft) { user.create_draft(subject: "test mail") }

    it 'deletes the draft if it exists' do
      user.delete_draft
      expect(user.draft).not_to be_present
    end
  end

end