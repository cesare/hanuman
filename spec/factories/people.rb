FactoryGirl.define do
  factory :person do
    name 'Test Person'
    sequence(:email) { |n| format 'test%03d@example.com', n }
    admin false

    trait :admin do
      admin true
    end

    factory :admin, traits: %i(admin)
  end
end
