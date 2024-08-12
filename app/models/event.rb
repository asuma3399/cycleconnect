class Event < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user  # イベントの作成者

  has_and_belongs_to_many :participants, class_name: 'User'

  validates :title, :description, :date, presence: true
  validates :garmin_url, format: { with: URI::regexp(%w[http https]), allow_blank: true }
end