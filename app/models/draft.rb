class Draft < ActiveRecord::Base
  belongs_to :user
  has_many :attachments, dependent: :destroy

  # def attachments_array=(array)
  #   array.each do |file|
  #   attachments.build(:attachment => file)
  # end

end