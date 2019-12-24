class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :postal_code,   null: false
      t.string :   
      t.timestamps
    end
  end
end
