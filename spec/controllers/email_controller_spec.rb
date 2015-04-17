require 'rails_helper'

RSpec.describe EmailController, type: :controller do

  include EmailHelper

  let(:user) { create(:user) }
  let(:current_user) { user }

  before :each do
    allow(controller).to receive(:ensure_sign_in) { true }
  end

  describe "#create_message" do
    before :each do
      @email = {to:  "to@gmail.com",
                cc:  "cc@gmail.com",
                bcc: "bcc@gmail.com",
                subject: "Test Message",
                body: "This is body"}
      allow(controller).to receive(:current_user) { user }
    end

    context 'when user click draft or send button' do
      it 'calls generate_draft model method on the current_user' do
        expect(current_user).to receive(:generate_draft).with(@email)
        post :create_message, { :email => @email }
      end
    end

    context "when user click send" do
      it 'calls deliver_message methods on draft model of the current_user' do
        expect(current_user).to receive(:draft)
        post :create_message, { :email => @email, :send_msg => true }
      end
    end

    context "when user click draft" do
      it 'calls create_message' do
        expect(current_user.draft).not_to receive(:deliver_message)
        post :create_message, { :email => @email, :draft_msg => true }
      end
    end

    after :each do
      expect(response).to redirect_to email_index_path
    end
  end

  describe "#delete_message" do
    it "redirects to email_index_path" do
      delete :delete_message
      expect(response).to redirect_to email_index_path
    end
  end

end