require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメントの投稿' do
    context 'コメントの投稿ができる場合' do
      it 'Textが入力されていればコメントの投稿ができる' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントの投稿ができない場合' do
      it 'Textが入力されていなければコメントの投稿ができない' do
        @comment.text = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
    end
  end
  # belongs_to :post
  it { is_expected.to belong_to(:post) }

  # belongs_to :user
  it { is_expected.to belong_to(:user) }
end
