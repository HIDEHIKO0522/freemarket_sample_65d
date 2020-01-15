FactoryBot.define do

  factory :item_image do
    item
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg'))}
  end

end