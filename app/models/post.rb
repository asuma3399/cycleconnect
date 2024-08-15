class Post < ApplicationRecord

  belongs_to :user
  has_many :comments
  has_many :likes
  has_many :post_tag_relations
  has_many :tags, through: :post_tag_relations
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

end
