class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A[\x20-\x7E]+\z/

  has_many :posts
  has_many :comments
  has_many :messages, dependent: :destroy
  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users
  has_many :likes
  has_and_belongs_to_many :events
  has_one_attached :icon

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :password, format: { with: VALID_PASSWORD_REGEX }, if: :password_required?
  validates :password, presence: true, on: :create
  validates :password, confirmation: true, allow_blank: true, if: :password_required?
  validates :bio, length: { maximum: 500 }

  private

  def password_required?
    new_record? || password.present?
  end
end