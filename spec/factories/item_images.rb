FactoryBot.define do

  factory :item_image do
    item
    image {File.open("#{Rails.root}/public/images/test_image.jpg")}
  end

end