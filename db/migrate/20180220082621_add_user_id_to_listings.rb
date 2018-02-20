class AddUserIdToListings < ActiveRecord::Migration[5.1]
  def change
    add_reference :listings, :user, foreign_key: true, index: true
  end
end
