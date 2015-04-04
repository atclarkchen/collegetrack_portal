class AddUserToToken < ActiveRecord::Migration
  def change
    add_reference :tokens, :user, index: true
    add_foreign_key :tokens, :users
  end
end