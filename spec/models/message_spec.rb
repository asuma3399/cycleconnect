require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージの送信' do
    context 'メッセージの送信ができる場合' do
      it 'contentが入力されていればメッセージが送信できる' do
        expect(@message).to be_valid
      end
      it 'contentがちょうど500文字であればメッセージが送信できる' do
        @message.content = 'a' * 500
        expect(@message).to be_valid
      end
    end

    context 'メッセージの送信ができない場合' do
      it 'contentが入力されていなければメッセージの送信ができない' do
        @message.content = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Content can't be blank")
      end
      it 'contentが空白のみの場合はメッセージが送信できない' do
        @message.content = ' ' * 10
        @message.valid?
        expect(@message.errors.full_messages).to include("Content can't be blank")
      end
      it 'contentが指定された文字数以上であればメッセージが送信できない' do
        @message.content = 'a' * 501
        @message.valid?
        expect(@message.errors.full_messages).to include("Content is too long (maximum is 500 characters)")
      end
      it 'userが存在しなければメッセージが送信できない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("User must exist")
      end
      it 'chat_roomが存在しなければメッセージが送信できない' do
      @message.chat_room = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Chat room must exist")
      end
    end
  end

  it 'ユーザーが削除されたとき、関連するメッセージも削除される' do
    @message.save
    expect { @message.user.destroy }.to change { Message.count }.by(-1)
  end

  it 'チャットルームが削除されたとき、関連するメッセージも削除される' do
    @message.save
    expect { @message.chat_room.destroy }.to change { Message.count }.by(-1)
  end

  # belongs_to :user
  it { is_expected.to belong_to(:user) }

  # belongs_to :chat_room
  it { is_expected.to belong_to(:chat_room) }
end
