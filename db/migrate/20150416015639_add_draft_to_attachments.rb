class AddDraftToAttachments < ActiveRecord::Migration
  def change
    add_reference :attachments, :draft, index: true
    add_foreign_key :attachments, :drafts
  end
end
