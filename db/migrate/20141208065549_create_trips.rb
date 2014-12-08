class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.text :blurb
      t.string :lat
      t.string :lng
      t.string :city
      t.string :start_date
      t.string :end_date

      t.timestamps
    end
  end
end
