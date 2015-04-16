class AddMessageToDraft < ActiveRecord::Migration
  def change
    add_column :drafts, :to,      :string
    add_column :drafts, :cc,      :string
    add_column :drafts, :bcc,     :string
    add_column :drafts, :subject, :string
    add_column :drafts, :body,    :string
  end
end
