FactoryBot.define do
  factory :image do |f|
    f.source { "#{Faker::Internet.url}/image.jpg" }
  end
end
