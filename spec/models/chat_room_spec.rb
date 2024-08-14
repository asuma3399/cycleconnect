require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @chat_room = FactoryBot.create(:chat_room)
    @chat_room_user = FactoryBot.create(:chat_room_user, chat_room: @chat_room, user: @user)
  end

  describe 'チャットルームの作成' do
    context 'チャットルームの作成ができる場合' do
      it 'Chat Room Nameが入力され、ユーザーが選択されていればチャットルームが作成できる' do
        expect(@chat_room).to be_valid
      end
    end

    context 'チャットルームの作成ができない場合' do
      it 'Chat Room Nameが空の場合はチャットルームの作成ができない' do
        @chat_room.name = nil
        @chat_room.valid?
        expect(@chat_room.errors.full_messages).to include("Name can't be blank")
      end
    end
  end

  it 'ユーザーがチャットルームに追加されているか確認できる' do
    expect(@chat_room.users).to include(@user)
  end
  it '複数のユーザーが同じチャットルームに追加されているか確認できる' do
    another_user = FactoryBot.create(:user)
    another_chat_room_user = FactoryBot.create(:chat_room_user, chat_room: @chat_room, user: another_user)
    expect(@chat_room.users).to include(@user, another_user)
  end
  it 'チャットルームは複数のChatRoomUserを持つ' do
    expect(@chat_room.chat_room_users).to include(@chat_room_user)
  end
  it '同じユーザーを同じチャットルームに複数回追加できない' do
    duplicate_chat_room_user = FactoryBot.build(:chat_room_user, chat_room: @chat_room, user: @user)
    expect(duplicate_chat_room_user).to_not be_valid
  end
end
