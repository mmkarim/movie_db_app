FactoryBot.define do
  factory :rating do
    user
    movie
    value {Faker::Number.between(1, 5)}
  end
end
