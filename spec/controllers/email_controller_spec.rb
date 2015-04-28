require 'rails_helper'

RSpec.describe EmailController, type: :controller do

  let(:user)  { create(:user)  }
  let(:current_user) { user }

  let(:draft) { create(:draft) }
  let(:email) { build(:email) }
  let(:message) { email.reject { |k,v| k == :files } }
  let(:files) { email[:files].values }

  before :each do
    allow(controller).to receive(:ensure_sign_in) { true }
    allow(controller).to receive(:current_user) { user }
  end

  describe "#create" do
    
    context 'when user click submit button (draft or send)' do
      it 'builds draft with message_params' do
        expect(current_user).to receive(:build_draft) { draft }
        post :create, { :email => email }
      end
      
      it 'add attachments to draft with files_params' do
        allow(controller).to receive(:files_params) { files }
        expect(draft).to receive(:add_attachments).with(files)
      end
    end

    context 'when user clicks send button' do
      it 'sends an email with current draft'
      context 'email has sent successfully' do
        it 'sets notice for successful delievery'
        it 'sends AJAX response to DropzoneJS'
      end
      context 'gmail API throws an error' do
        it 'sets notice for unsuccessful delievery'
      end
    end

    context 'when user clicks draft button' do
      it 'saves the current draft and attachments'
      it 'sets notice for saving draft'
    end

    it 'redirect_to to email_index_path'
  end

  describe '#message_params' do
    it 'generate string of message params' do
      allow(controller).to receive(:strong_params) { message }
      msg_params = controller.send(:message_params)
      expect(msg_params.values).to all (be_an(String))
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