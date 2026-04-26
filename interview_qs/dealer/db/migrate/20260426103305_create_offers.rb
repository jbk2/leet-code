class CreateOffers < ActiveRecord::Migration[8.1]
  def change
    create_table :offers do |t|
      t.integer :price, null: false
      t.references :dealer_profile, null: false, foreign_key: true
      t.references :request, null: false, foreign_key: true
      t.index [:dealer_profile_id, :request_id], unique: true
      
      t.timestamps
    end
  end
end
