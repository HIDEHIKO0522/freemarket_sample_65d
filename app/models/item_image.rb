class ItemImage < ApplicationRecord
  validates :image, presence: true
  belongs_to :item
  mount_uploader :image, ImageUploader
end
