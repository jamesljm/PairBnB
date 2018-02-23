class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.timestamps null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :user, index: true, foreign_key: true
      t.references :listing, index: true, foreign_key: true      

    end
  end
end
