FactoryBot.define do
  factory :registration do
    association :user
    association :event
  end
end
