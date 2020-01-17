class RemovePointFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :point, :integer
    remove_column :users, :sales, :integer
  end
end
