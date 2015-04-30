require 'rails_helper'

RSpec.describe EmailController, type: :controller do

  include ActionDispatch::TestProcess

  let(:user)  { create(:user)  }
  let(:current_user) { user }

  let(:email) { build(:email) }
  let(:message) { email.reject { |k,v| k == :files } }
  let(:files) { email[:files].values }

  before :each do
    allow(controller).to receive(:ensure_sign_in) { true }
    allow(controller).to receive(:current_user)   { user }
  end

  describe '#index' do
    
    context 'when user wants to create a new email' do
      it 'should call #new method' do
        get :index
        expect(response).to redirect_to(new_email_path)
      end
    end

  end

  describe '#new' do
    it 'calls #get_filter_values and assign the result' do
      expect(controller).to receive(:get_filter_values)
      get :new
    end
  end

  describe "#create" do

    let(:invalid_email) { build(:email, subject: "") }
    let(:draft)         { create(:draft) }

    context 'when user submit valid email' do
      it 'creates draft with valid parameters' do
        expect {
          post :create, { :email => email }
        }.to change(Draft, :count).by(1)
      end

      context 'when user press send button' do
        it 'calls #send_draft' do
          expect(controller).to receive(:send_draft)
          post :create, { :email => email, :user_press => "Send" }
        end
      end

      context 'when user press draft button' do
        it 'assign draft to the current user' do
          allow(Draft).to receive(:new).and_return(draft)
          post :create, { :email => email, :user_press => "Draft" }
          expect(current_user.draft).to eq(draft)
        end
      end
    end

    context "when user submit invalid email" do
      it 'should fail to save with invalid parameters' do
        expect{
          post :create, { :email => invalid_email }
        }.not_to change(Draft, :count)
      end
    end
  end

  describe '#destroy' do
    it 'delete the draft of user if it exists' do
      expect(current_user).to receive(:delete_draft)
      delete :destroy
    end
  end

  describe '#message_params' do
    it 'generate string of message params' do
      allow(controller).to receive(:strong_params) { message }
      msg_params = controller.send(:message_params)
      expect(msg_params.values).to all (be_an(String))
    end
  end

end