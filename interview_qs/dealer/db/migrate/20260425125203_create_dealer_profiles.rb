class CreateDealerProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :dealer_profiles do |t|
      t.string :dealer_name
      t.decimal :dealer_rating, precision: 2, scale: 1

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
