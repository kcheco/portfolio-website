FactoryBot.define do
  factory :project do |f|
    f.name { "#{Faker::GreekPhilosophers.quote}" }
    f.date_completed { "#{Faker::Date.between(Date.today, 5.years.ago)}" }
    f.link { "#{Faker::Internet.url}" }
  end
end
