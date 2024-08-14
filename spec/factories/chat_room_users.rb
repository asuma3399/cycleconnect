FactoryBot.define do
  factory :chat_room_user do
    association :chat_room
    association :user
  end
end
