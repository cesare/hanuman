FactoryGirl.define do
  factory :user do
    name 'Test User'
    uid '12345'
    provider 'google'

    trait :github do
      provider 'github'
    end
  end
end
