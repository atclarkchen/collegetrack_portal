class AddMessageToDraft < ActiveRecord::Migration
  def change
    add_column :drafts, :subject, :string
    add_column :drafts, :body,    :text
    add_column :drafts, :to,      :text
    add_column :drafts, :cc,      :text
    add_column :drafts, :bcc,     :text
  end
end