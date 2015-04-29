class AddAttachmentFileToAttachments < ActiveRecord::Migration
  def self.up
    add_attachment :attachments, :source
  end

  def self.down
    remove_attachment :attachments, :source
  end
end
