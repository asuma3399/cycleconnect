require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryBot.build(:event)
  end

  describe 'イベントの作成' do
    context 'イベントの作成ができる場合' do
      it 'title、description、date、garmin_urlが入力されていればイベントが作成できる' do
        expect(@event).to be_valid
      end
      it 'garmin_urlは空でもイベントが作成できる' do
        @event.garmin_url = nil
        expect(@event).to be_valid
      end
      it 'イベントに参加者を追加できる' do
        user = FactoryBot.create(:user)
        @event.participants << user
        expect(@event.participants).to include(user)
      end
      it 'イベントから参加者を削除できる' do
        user = FactoryBot.create(:user)
        @event.participants << user
        @event.participants.delete(user)
        expect(@event.participants).not_to include(user)
      end
    end

    context 'イベントの作成ができない場合' do
      it 'titleが入力されていなければイベントが作成できない' do
        @event.title = nil
        @event.valid?
        expect(@event.errors.full_messages).to include("Title can't be blank")
      end
      it 'descriptionが空ではイベントが作成できない' do
        @event.description = nil
        @event.valid?
        expect(@event.errors.full_messages).to include("Description can't be blank")
      end
      it 'dateが空ではイベントが作成できない' do
        @event.date = nil
        @event.valid?
        expect(@event.errors.full_messages).to include("Date can't be blank")
      end
      it 'garmin_urlが正しいURL形式でない場合はイベントが作成できない' do
        @event.garmin_url = 'invalid_url'
        @event.valid?
        expect(@event.errors.full_messages).to include("Garmin url is invalid")
      end
    end
  end
  describe 'associations' do
    it { should have_and_belong_to_many(:participants).class_name('User') }
  end
    # belongs_to :chat_room
    it { is_expected.to belong_to(:chat_room) }

    # belongs_to :user
    it { is_expected.to belong_to(:user) }
end
