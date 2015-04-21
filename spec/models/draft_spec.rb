require 'rails_helper'

RSpec.describe Draft, type: :model do
  
  include ActionDispatch::TestProcess

  let(:draft) { create(:draft_with_attachment) }
  let(:file)  { build(:attachment).file }
  let(:email) { {to:  ["to@gmail.com"],
                 cc:  ["cc@gmail.com"],
                 bcc: ["bcc@gmail.com", "bcc2@gmail.com"],
                 subject: "Test Message",
                 body: "This is body"} }

  describe '#string_attributes' do
    it 'extract files from email hash' do
      result = draft.string_attributes(email)
      expect(result[:to]).to eq 'to@gmail.com'
      expect(result[:cc]).to eq 'cc@gmail.com'
      expect(result[:bcc]).to eq 'bcc@gmail.com, bcc2@gmail.com'
    end
  end

  describe '#add_attachments' do
    it 'creates new attachment models' do
      expect(draft.attachments).to receive(:create).with({file: file})
      draft.add_attachments([file])
    end
  end
end