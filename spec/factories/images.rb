FactoryBot.define do
  factory :image do |f|
    f.source { Faker::Placeholdit.image('300x300', 'jpg') }
  end
end
