require 'rails_helper'

RSpec.describe EmailController, type: :controller do

  include EmailHelper

  let(:user)  { create(:user) }
  let(:draft) { create(:draft) }
  let(:email) { {to:  ["to@gmail.com"],
                cc:  ["cc@gmail.com"],
                bcc: ["bcc@gmail.com", "bcc2@gmail.com"],
                subject: "Test Message",
                body: "This is body",
                files: [""]} }
  let(:current_user) { user }

  before :each do
    allow(controller).to receive(:ensure_sign_in) { true }
  end

  describe '#string_params' do
    it 'call require on params' do
      allow(controller).to receive(:email_params) { email }
      string_email = controller.send(:string_params)
      expect(string_email[:to].class).to    eq String
      expect(string_email[:cc].class).to    eq String
      expect(string_email[:bcc].class).to   eq String
      expect(string_email[:files].class).to eq Array
    end
  end

  # describe "#create" do
  #   before :each do
  #     allow(controller).to receive(:current_user) { user }
  #   end

  #   context 'when user click draft or send button' do
  #     it 'calls generate_draft model method on the current_user' do
  #       expect(current_user).to receive(:create_draft).and_return(draft)
  #       allow(draft).to receive(:compose_draft).with(email)
  #       post :create_message, { :message => email }
  #     end

  #     it 'calls save_draft method on draft model' do
  #       allow(current_user).to receive(:create_draft).and_return(draft)
  #       expect(draft).to receive(:compose_draft).with(email)
  #       post :create_message, { :message => email }
  #     end
  #   end

  #   context 'when user click send button' do
  #     it 'calls deliver_message method on EmailController' do
  #       allow(current_user).to receive(:create_draft).and_return(draft)
  #       allow(draft).to receive(:compose_draft).with(email)
  #       expect(controller).to receive(:deliver_message).with(draft)
  #       post :create_message, { :message => email, :send_msg => true}
  #     end
  #   end

  #   # after :each do
  #   #   expect(response).to redirect_to email_index_path
  #   # end
  # end

  # describe "#delete_message" do
  #   it "redirects to email_index_path" do
  #     delete :delete_message
  #     expect(response).to redirect_to email_index_path
  #   end
  # end

end