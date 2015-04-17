class CreateSalesforceClients < ActiveRecord::Migration
  def change
    create_table :salesforce_clients do |t|
      t.string :username
      t.string :password
      t.string :security_token

      t.timestamps null: false
    end
  end
end
