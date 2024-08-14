require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    @profile = FactoryBot.build(:profile)
  end

  describe 'プロフィールの作成' do
    context 'プロフィールの作成ができる場合' do
      it 'bioが入力され、profile iconが選択されていればプロフィールが作成できる' do
        expect(@profile).to be_valid
      end
      it 'bioは空でもプロフィールの作成ができる' do
        @profile.bio = nil
        expect(@profile).to be_valid
      end
      it 'profile iconが空でもプロフィールの作成ができる' do
        @profile.avatar = nil
        expect(@profile).to be_valid
      end
      it 'bio、profile iconが空でもプロフィールが作成できる' do
        @profile.bio = nil
        @profile.avatar = nil
        expect(@profile).to be_valid
      end
    end

    context 'プロフィールが作成できない場合' do
      it 'ユーザーが紐づいていない場合、プロフィールが作成できない' do
        @profile.user = nil
        @profile.valid?
        expect(@profile.errors.full_messages).to include("User must exist")
      end
      it 'avatarが無い場合、プロフィールの作成ができない' do
        @profile.avatar = nil
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Avatar must exist")
      end
    end
  end
end
