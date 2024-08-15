class Post < ApplicationRecord
  validates :description, presence: true
  validates :image, presence: true
  validate :validate_image_type  # 画像タイプのバリデーションを追加
  validates :latitude, presence: true
  validates :longitude, presence: true

  belongs_to :user
  has_many :comments
  has_many :likes
  has_one_attached :image

  # ユーザーが該当ポストをいいね済かどうか判定するメソッド
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def self.search(search)
    if search != ""
      Post.where('description LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end

  private

  # 画像がJPEGまたはPNGのみであることを保証するバリデーションメソッド
  def validate_image_type
    if image.attached?
      allowed_types = ['image/jpeg', 'image/png']
      unless allowed_types.include?(image.blob.content_type)
        errors.add(:image, 'はJPEGまたはPNGフォーマットである必要があります。')
      end
    end
  end

end
