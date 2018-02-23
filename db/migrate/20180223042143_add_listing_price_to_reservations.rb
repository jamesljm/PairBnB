class AddListingPriceToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :listing_price, :integer
  end
end
