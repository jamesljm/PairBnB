class AddCityToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :city, :string
  end
end
