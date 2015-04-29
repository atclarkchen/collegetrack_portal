class Attachment < ActiveRecord::Base
  belongs_to :draft
  has_attached_file :source

  validates_attachment_size :source, :less_than => 5.megabytes
  do_not_validate_attachment_file_type :source

  def read_from_s3
    {
      filename: source_file_name,
      content:  open(source.url).read
    }
  end

end