class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.boolean :kitchen, default: false
      t.text :amenities, array: true, default: []

      t.timestamps null: false
    end
  end
end
