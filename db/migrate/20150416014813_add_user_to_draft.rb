class AddUserToDraft < ActiveRecord::Migration
  def change
    add_reference :drafts, :user, index: true
    add_foreign_key :drafts, :users
  end
end
