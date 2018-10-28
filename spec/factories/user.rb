FactoryBot.define do
  factory :user do
    password {"aa123456"}
    email {Faker::Internet.email}
  end
end
