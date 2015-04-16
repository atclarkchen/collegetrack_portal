class Draft < ActiveRecord::Base
  belongs_to :user
  has_many :attachments, dependent: :destroy
end