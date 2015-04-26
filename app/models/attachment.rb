class Attachment < ActiveRecord::Base
  belongs_to :draft
  has_attached_file :source

  attr_accessor :source_file_name, :source_file_size

  validates_attachment_size :source, :less_than => 5.megabytes
  do_not_validate_attachment_file_type :source
end