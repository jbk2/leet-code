class SetDefaultDealerRatingOnDealerProfiles < ActiveRecord::Migration[8.1]
  def change
    DealerProfile.where(dealer_rating: nil).update_all(dealer_rating: 5.0)
    
    change_column_default :dealer_profiles, :dealer_rating, 5.0
    change_column_null :dealer_profiles, :dealer_rating, false
  end
end
