require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '写真の投稿' do
    context '写真の投稿ができる場合' do
      it 'Description、画像、Latitude、Longitudeが入力されていれば写真の投稿ができる' do
        expect(@post).to be_valid
      end
    end
    context '写真の投稿ができない場合' do
      it '画像がついていなければ投稿できない' do
        @post.image = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Image can't be blank")
      end
      it '画像がJPEGまたはPNG形式でなければ投稿できない' do
        @post.image = fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.gif'), 'image/gif')
        @post.valid?
        expect(@post.errors.full_messages).to include("Image はJPEGまたはPNGフォーマットである必要があります。")
      end
      it 'Descriptionが入力されていなければ投稿できない' do
        @post.description = nil
        @post.valid?
        expect(@post.errors.full_messages). to include("Description can't be blank")
      end
      it 'Latitudeが入力されていなければ投稿できない' do
        @post.latitude = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Latitude can't be blank")
      end
      it 'Longitudeが入力されていなければ投稿できない' do
        @post.longitude = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Longitude can't be blank")
      end
      it 'ユーザーが紐づいていない場合は投稿できない' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("User must exist")
      end
    end
  end
  # belongs_to :user
  it { is_expected.to belong_to(:user) }

  # has_many :comments
  it { is_expected.to have_many(:comments) }

  # has_many :likes
  it { is_expected.to have_many(:likes) }

  # has_one_attached :image
  it { is_expected.to have_one_attached(:image) }
end
