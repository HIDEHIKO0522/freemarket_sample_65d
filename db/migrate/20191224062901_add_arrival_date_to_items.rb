class AddArrivalDateToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :arrival_date, :integer, null: false
  end
end
