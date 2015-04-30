require 'rails_helper'

RSpec.describe Draft, type: :model do
  
  let(:files) { build(:email)[:files].values }
  let(:draft) { Draft.create(subject: "temp draft") }

  describe '#add_attachments=' do
    it 'add attachments with incomming array of files' do
      expect {
        draft.add_attachments = files
        draft.save
      }.to change(Attachment, :count).by(2)
    end
  end
end