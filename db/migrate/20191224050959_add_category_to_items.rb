class AddCategoryToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :category, null: false, foreign_key: true
  end
end
