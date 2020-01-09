class Item < ApplicationRecord
  validates :name, :comment, :condition, :size, :price, :arrival_date, :charge, :location, :delivery, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 300 }
  validate :check_category
  belongs_to :buyer, class_name: 'User', optional: true
  belongs_to :seller, class_name: 'User'
  has_many :item_images, dependent: :destroy
  belongs_to :category

  def check_category
    unless category.present? && category.has_grand_parent?
      errors.add(:category, "を選択してください")
    end
  end
end
