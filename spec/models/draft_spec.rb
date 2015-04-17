require 'rails_helper'

RSpec.describe Draft, type: :model do
  describe '#save_draft' do
    let(:draft) { create(:draft) }
    let(:email) { {to:  "to@gmail.com",
                cc:  "cc@gmail.com",
                bcc: ["bcc@gmail.com", "bcc2@gmail.com"],
                subject: "Test Message",
                body: "This is body"} }

    it 'converts array class of bcc into merged string' do
      
    end
  end
end
