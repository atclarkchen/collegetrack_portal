class Draft < ActiveRecord::Base
  belongs_to :user
  has_many :attachments, dependent: :destroy

  accepts_nested_attributes_for :attachments, reject_if: proc { |file| file['source'].blank? }

  def compose_draft(email)
    files = email.delete(:files)
    self.attributes string_attributes(email)
    add_attachments(files) if files.presence
  end

  def string_attributes(email)
    email.each do |key, val|
      if val.class == Array
        email[key] = val.compact.reject(&:empty?).join(", ")
      end
    end
  end

  def add_attachments(files)
    files.each do |file|
      self.attachments.create(file: file)
    end
  end

end