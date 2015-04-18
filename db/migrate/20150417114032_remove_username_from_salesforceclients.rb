class RemoveUsernameFromSalesforceclients < ActiveRecord::Migration
  def change
    remove_column :salesforce_clients, :username, :string
  end
end
