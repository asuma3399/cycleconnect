class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
  has_many :messages, dependent: :destroy
  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users
  has_and_belongs_to_many :events
  has_one_attached :icon
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :bio, length: { maximum: 500 }

end
