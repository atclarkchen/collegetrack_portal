class Draft < ActiveRecord::Base
  belongs_to :user
  has_many :attachments, dependent: :destroy

  validates :subject, presence: true

  def add_attachments=(files)
    files.each do |file|
      attachments.build(:source => file)
    end
  end

end