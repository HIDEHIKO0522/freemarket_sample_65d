class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :comment, null: false
      t.string :condition, null: false
      t.string :brand
      t.integer :complete_day
      t.references :seller, null: false, foreign_key: { to_table: :users }
      t.references :buyer, foreign_key: { to_table: :users }
      t.string :size
      t.integer :price, null: false
      t.string :arrival_date, null: false
      t.string :charge, null: false
      t.string :location, null: false
      t.string :status
      t.string :delivery

      t.timestamps

    end
  end
end
