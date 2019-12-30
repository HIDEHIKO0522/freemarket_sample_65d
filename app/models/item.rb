class Item < ApplicationRecord
  validates :name, :comment, :condition, :size, :price, :arrival_date, :charge, :location, :delivery, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 300 }
  belongs_to :buyer, class_name: 'User', optional: true
  belongs_to :seller, class_name: 'User'
  has_many :item_images
  belongs_to :category
end
