FactoryBot.define do
  factory :chat_room do
    name { Faker::Lorem.sentence }
  end
end