class AddPriceToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :price, :integer
  end
end
