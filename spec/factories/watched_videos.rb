FactoryBot.define do
  factory :watched_video do |f|
    f.title { "#{Faker::Movie.quote}" }
    f.date_viewed { "#{Faker::Date.between(Date.today, 5.years.ago)}" }
    f.link { "#{Faker::Internet.url}" }
  end
end
