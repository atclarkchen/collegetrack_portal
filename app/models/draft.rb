class Draft < ActiveRecord::Base
  belongs_to :user
  has_many :attachments, dependent: :destroy

  def save_draft(email)
    email[:bcc] = merge_bcc_to_string(email[:bcc])
    files = email.delete(:file)
    self.update_attributes email
    self.add_attachments(files) if files.presence
  end

  def merge_bcc_to_string(array_bcc)
    array_bcc.compact.reject(&:empty?).join(", ")
  end

  def add_attachments(files)
    files.each do |file|
      self.attachments.create(file: file)
    end
  end

  def deliver_message
    gmail = Gmail.connect(:xoauth2, self.user.email,
                                    self.user.token.fresh_token)
    message = compose_message(gmail)
    message.deliver!
    gmail.logout
  end

  def compose_message(gmail)
    draft = self
    message = gmail.compose do
      to   draft.to
      cc   draft.cc
      bcc  draft.bcc

      subject  draft.subject
      html_part do
        content_type "text/html; charset=UTF-8"
        body  draft.body
      end
    end

    # Add attachments to message
    self.attachments.each do |attachment|
      message.add_file load_file(attachment)
    end

    return message
  end

  def load_file(attachment)
    {
      filename: attachment.file_file_name,
      content: open(attachment.file.url).read
    }
  end

end