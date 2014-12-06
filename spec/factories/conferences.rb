FactoryGirl.define do
  factory :conference do
    name 'Testing Conference'
    description 'This is testing conference'

    trait :published do
      published true
    end

    trait :unpublished do
      published false
    end
  end
end
