FactoryBot.define do
  factory :project do |f|
    sequence(:name) { |n| "#{Faker::GreekPhilosophers.quote} #{n}" }
    f.date_completed { "#{Faker::Date.between(Date.today, 5.years.ago)}" }
    f.link { "#{Faker::Internet.url}" }

    trait(:with_cover) do
      association(:image)
    end
  end
end
