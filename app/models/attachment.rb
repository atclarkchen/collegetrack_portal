class Attachment < ActiveRecord::Base
  belongs_to :draft
  has_attached_file :file
end