require 'rails_helper'

RSpec.describe Attachment, type: :model do
  describe 'Attachment' do
    it { should have_attached_file(:file) }
    it { should validate_attachment_size(:file).
                  less_than(5.megabytes) }
  end
end