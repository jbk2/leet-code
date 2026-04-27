class AddStateToOffers < ActiveRecord::Migration[8.1]
  def change
    add_column :offers, :state, :integer
    
    reversible do |dir|
      dir.up do
        execute "UPDATE offers SET state = 0 WHERE state IS NULL"
      end
    end
    
    change_column_default :offers, :state, from: nil, to: 0
    change_column_null :offers, :state, false
    add_index :offers, :state
  end
end
