FactoryBot.define do
  factory :movie do
    name {Faker::Name.name}
    average_rating {Faker::Number.between(1, 5)}
    text {Faker::Lorem.sentence}
    user
  end
end
