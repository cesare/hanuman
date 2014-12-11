FactoryGirl.define do
  factory :person do
    name 'Test Person'
    admin false

    trait :admin do
      admin true
    end

    factory :admin, traits: %i(admin)
  end
end
