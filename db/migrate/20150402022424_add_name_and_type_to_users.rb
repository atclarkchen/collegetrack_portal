class AddNameAndTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :type, :string
  end
end
