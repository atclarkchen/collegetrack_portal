class AddMessageToDraft < ActiveRecord::Migration
  def change
    add_column :drafts, :message, :string
  end
end
