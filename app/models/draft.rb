class Draft < ActiveRecord::Base
  belongs_to :user
  has_many :attachments, dependent: :destroy

  def add_attachments=(files)
    files.each do |file|
      attachments.create(:source => file)
    end
  end

end