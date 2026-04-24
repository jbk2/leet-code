class AddIndexToUsersAccountType < ActiveRecord::Migration[8.1]
  def change
    add_index :users, :account_type
  end
end
