class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :user, foreign_key: true
      t.integer :sales, default: 0
      t.integer :point, default: 0

      t.timestamps
    end
  end
end
