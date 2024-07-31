class Post < ApplicationRecord
  validates :description, presence: true
  validate :validate_image_type  # 画像タイプのバリデーションを追加

  belongs_to :user
  has_many :comments
  has_one_attached :image

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
