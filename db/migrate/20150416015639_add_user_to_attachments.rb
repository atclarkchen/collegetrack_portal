class AddUserToAttachments < ActiveRecord::Migration
  def change
    add_reference :attachments, :user, index: true
    add_foreign_key :attachments, :users
  end
end
