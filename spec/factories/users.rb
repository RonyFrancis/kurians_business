FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.first_name }
    forward_email { Faker::Name.first_name + '@gmail.com' }
    auth_token { Faker::Number.number(10) }
    mobile_number { Faker::Number.number(10) }
    trait :admin do
      is_admin { true }
    end
    trait :user do
      is_admin { false }
    end
  end
end
