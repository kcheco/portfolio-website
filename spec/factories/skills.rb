FactoryBot.define do
  factory :skill do |f|
    f.name { "#{Faker::ProgrammingLanguage.name}" }
  end
end