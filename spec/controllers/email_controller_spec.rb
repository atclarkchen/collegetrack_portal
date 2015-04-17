require 'rails_helper'

RSpec.describe EmailController, type: :controller do
  
  include EmailHelper

  before :each do
    controller.stub(:ensure_sign_in).and_return(true)
  end

  describe "#create_message" do
    before :each do
      @email = {to:  "to@gmail.com",
                cc:  "cc@gmail.com",
                bcc: "bcc@gmail.com",
                subject: "Test Message",
                body: "This is body",
                file: ["test.jpg", "sample.pdf"]}
    end

    context 'when user click draft or send button' do
      it 'calls create_message' do
        expect(controller).to receive(:create_message).with(@email)
        post :send_message, { :email => @email }
      end
    end

    # context "when user click draft" do
    #   it 'calls create_message' do
    #     expect(controller).to receive(:create_message).with(@email)
    #     post :send_message, { :email => @email, :draft_msg => true }
    #   end
    # end

    # context "when user click send" do
    #   it 'calls create_message' do
    #     expect(controller).to receive(:create_message).with(@email)
    #     post :create_message, { :email => @email, :send_msg => true }
    #   end
    # end

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