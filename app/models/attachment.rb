class Attachment < ActiveRecord::Base
  belongs_to :draft
  has_attached_file :file

  validates_attachment_size :file, :less_than => 5.megabytes
  do_not_validate_attachment_file_type :file
end