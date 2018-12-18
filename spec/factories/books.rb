FactoryBot.define do
  factory :book do |f|
    f.title { "#{Faker::Book.title}" }
    f.date_read { "#{Faker::Date.between(Date.today, 5.years.ago)}" }
  end
end
