FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    date { Faker::Date.forward }
    garmin_url { Faker::Internet.url(host: 'garmin.com') }
    association :chat_room
    association :user
  end
end
