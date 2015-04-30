require 'rails_helper'

RSpec.describe Attachment, type: :model do
  describe 'Paperclip' do
    it { should have_attached_file(:source) }
    it { should validate_attachment_size(:source).
                  less_than(5.megabytes) }
  end

  describe '#read_from_s3' do

    let(:attachment) { create(:attachment) }
    let(:read) { stub('open') }

    it 'returns a hash of contents' do
      attachment.stub_chain(:open, :read).and_return("binary_string")
      expect(attachment.read_from_s3).to be_a(Hash)
    end
  end

end