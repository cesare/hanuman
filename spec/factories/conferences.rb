FactoryGirl.define do
  factory :conference do
    name 'Testing Conference'
    description 'This is testing conference'
    begins_at { 10.days.from_now.change(hour: 10) }
    ends_at   { 10.days.from_now.change(hour: 18) }

    trait :published do
      published true
    end

    trait :unpublished do
      published false
    end

    trait :past do
      begins_at { 10.days.ago.change(hour: 10) }
      ends_at   { 10.days.ago.change(hour: 18) }
    end
  end
end
