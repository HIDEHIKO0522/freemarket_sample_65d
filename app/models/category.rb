class Category < ApplicationRecord
  validates :name, presence: true
  has_many :items
  has_ancestry

  def has_grand_parent?
    if self.has_parent?
      return true if self.parent.has_parent?
    end
  end

end
