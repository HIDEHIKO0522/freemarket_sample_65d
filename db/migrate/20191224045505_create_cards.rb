class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :type,                null: false
      t.string  :number,              null: false
      t.string  :security_code,       null: false
      t.integer :user_id,             null: false, foreign_key: true
      t.string  :expiration_date,     null: false
      t.timestamps
    end
  end
end
