class AddMessageToDraft < ActiveRecord::Migration
  def change
    add_column :drafts, :to,      :string
    add_column :drafts, :subject, :string
    add_column :drafts, :body,    :string
    add_column :drafts, :files,   :text
    add_column :drafts, :bcc,     :text
    add_column :drafts, :cc,      :text
  end
end
