FactoryBot.define do
  factory :watched_video do |f|
    sequence(:title) { |n| "#{Faker::Movie.quote} #{n}" }
    f.date_viewed { "#{Faker::Date.between(Date.today, 5.years.ago)}" }
    f.link { "#{Faker::Internet.url}" }
  end

  trait :with_cover do
    association(:image)
  end
end
