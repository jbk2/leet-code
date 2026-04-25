class UpdateDealerRatingPrecisionOnDealerProfile < ActiveRecord::Migration[8.1]
  def change
    change_column :dealer_profiles, :dealer_rating, :decimal, precision: 3, scale: 1
  end
end
