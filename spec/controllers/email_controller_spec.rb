require 'rails_helper'

RSpec.describe EmailController, type: :controller do
  
  include EmailHelper

  before :each do
    controller.stub(:ensure_sign_in).and_return(true)
  end

  describe "#send_message" do
    before :each do
      @email = {to:  "to@gmail.com",
                cc:  "cc@gmail.com",
                bcc: "bcc@gmail.com",
                subject: "Test Message",
                body: "This is body"}
    end

    context "when user click send" do
      it 'calls send_email method' do
        expect(controller).to receive(:send_email).with(@email)
        post :send_message, { :email => @email, :send_msg => true }
      end
    end

    context "when user click draft" do
      it 'calls save_draft method' do
        expect(controller).to receive(:save_draft).with(@email)
        post :send_message, { :email => @email, :draft_msg => true }
      end
    end

    after :each do
      expect(response).to redirect_to email_index_path
    end

  end

end