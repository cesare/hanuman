FactoryGirl.define do
  factory :user do
    name 'Test User'
    uid '12345'
    provider 'google'
  end
end
