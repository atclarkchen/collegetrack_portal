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

  describe '#new' do
    it 'calls #get_filter_values and assign the result' do
      expect(controller).to receive(:get_filter_values)
      get :new
    end
  end

  describe "#create" do

    let(:header) { message.select { |k,v| /to|cc|bcc|subject/ === k } }

    before :each do
      allow(controller).to receive(:email_handler) { true }
      allow(controller).to receive(:msg_header) { header }
    end

    it 'creates a new Mail object' do
      expect(Mail).to receive(:new).with(header)
      post :create, { :email => email }
    end

  end

  # describe '#send_draft' do
    
  #   include Mail::Matchers
  #   let(:mock_draft) { create(:draft) }
  #   let(:gmail) { double(Gmail) }

  #   before :each do
  #     Mail::TestMailer.deliveries.clear

  #     @message = Mail.deliver do
  #       to      ['mikel@me.com', 'mike2@me.com']
  #       from    'you@you.com'
  #       subject 'testing'
  #       body    'hello'
  #     end

  #     allow(Gmail).to receive(:connect).and_return(gmail)
  #     allow(gmail).to receive(:compose).and_return(@message)
  #     allow(gmail).to receive(:logout).and_return(true)
  #     controller.send(:send_draft, mock_draft)
  #   end

  #   it { should have_sent_email }

  # end

  # describe '#delete' do
  #   it 'delete the draft of user if it exists' do
  #     expect(current_user).to receive(:delete_draft)
  #     delete :delete
  #   end
  # end

  # describe '#message_params' do
  #   it 'generate string of message params' do
  #     allow(controller).to receive(:strong_params) { message }
  #     msg_params = controller.send(:message_params)
  #     expect(msg_params.values).to all (be_an(String))
  #   end
  # end

end