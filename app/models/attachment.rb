class Attachment < ActiveRecord::Base
  belongs_to :user
  has_attached_file :source,
            :url => "/tmp/:class/:attachment/:filename",
            :path => ":rails_root/tmp/:class/:attachment/:filename"

  validates_attachment_size :source, :less_than => 5.megabytes
  do_not_validate_attachment_file_type :source

  def path
    self.source.path
  end

end