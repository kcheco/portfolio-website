FactoryBot.define do
  factory :book do |f|
    f.title { "#{Faker::Book.title}" }
    f.date_read { "#{Faker::Date.between(Date.today, 5.years.ago)}" }
    f.link { "#{Faker::Internet.url}" }

    trait :with_cover do
      association(:image)
    end
  end
end
