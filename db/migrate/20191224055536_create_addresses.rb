class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :user,        foreign_key: true
      t.integer :postal_code,    null: false
      t.string  :prefectures,    null: false
      t.string  :city,           null: false
      t.string  :house_number,   null: false
      t.string  :building,       null: false
      t.integer :phone_number,   null: false, uniqueness: true
      t.integer :type,           null: false    
      t.timestamps
    end
  end
end