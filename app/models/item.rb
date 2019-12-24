class Item < ApplicationRecord
  belongs_to :buyer, class_name: 'User'
  belongs_to :seller, class_name: 'User'
  has_many :item_images
  belongs_to :category
end
