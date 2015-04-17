class Draft < ActiveRecord::Base
  belongs_to :user
  has_many :attachments, dependent: :destroy

  serialize :files, Array
  serialize :bcc
  serialize :cc

  # Callback triggered when build_draft is called
  after_initialize do |draft|
    debugger
    bcc = merge_bcc_to_string
    add_attachments if files.presence
  end

  def merge_bcc_to_string
    if bcc.class == Array
      bcc.compact.reject(&:empty?).join(", ")
    end
  end

  def add_attachments
    files.each do |file|
      self.attachments.build(file: file)
    end
  end

  # def deliver_message
  #   gmail = Gmail.connect(:xoauth2, self.user.email,
  #                                   self.user.token.fresh_token)
  #   message = compose_message(gmail)
  #   message.deliver!
  #   gmail.logout
  # end

  # def compose_message(gmail)
  #   draft = self
  #   message = gmail.compose do
  #     to   draft.to
  #     cc   draft.cc
  #     bcc  draft.bcc

  #     subject  draft.subject
  #     html_part do
  #       content_type "text/html; charset=UTF-8"
  #       body  draft.body
  #     end
  #   end

  #   # Add attachments to message
  #   self.attachments.each do |attachment|
  #     message.add_file load_file(attachment)
  #   end

  #   return message
  # end

  # def load_file(attachment)
  #   {
  #     filename: attachment.file_file_name,
  #     content: open(attachment.file.url).read
  #   }
  # end

end