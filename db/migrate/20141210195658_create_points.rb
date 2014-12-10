class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :user_id
      t.string :name
      t.string :location
      t.text :description
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
