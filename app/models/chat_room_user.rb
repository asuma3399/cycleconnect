class ChatRoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :user_id, uniqueness: { scope: :chat_room_id, message: "はこのチャットルームにすでに追加されています" }
end
