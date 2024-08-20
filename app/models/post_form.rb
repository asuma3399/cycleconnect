class PostForm
  include ActiveModel::Model

  attr_accessor( :id, :title, :description, :date, :chat_room_id, :user_id, :created_at,
    :updated_at, :garmin_url, :tag_name, :image, :latitude, :longitude, :likes_count
  )

  validates :description, presence: true
  validates :image, presence: true
  validate :validate_image_type
  validates :latitude, presence: true
  validates :longitude, presence: true

  def save
    post = Post.create(description: description, user_id: user_id, image: image,
    latitude: latitude, longitude: longitude
    )

    if tag_name.present?
      tag = Tag.where(tag_name: tag_name).first_or_initialize
      tag.save
      PostTagRelation.create(post_id: post.id, tag_id: tag.id)
    end
  end

  private

  def validate_image_type
    if image.attached?
      allowed_types = ['image/jpeg', 'image/png']
      unless allowed_types.include?(image.content_type)
        errors.add(:image, 'はJPEGまたはPNGフォーマットである必要があります。')
      end
    end
  end
end