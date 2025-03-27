FactoryBot.define do
  factory :event do
    title { Faker::Lorem.words(number: 3).join(" ") }
    description { Faker::Lorem.sentence }
    date { Faker::Time.forward(days: 10) }
    num_of_attendees { rand(5..50) }
    remaining_seats { num_of_attendees }
    association :user
  end
end
