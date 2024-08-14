FactoryBot.define do
  factory :profile do
    bio { Faker::Lorem.sentence }
    association :user

    after(:build) do |profile|
      profile.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'avatar.png')),
        filename: 'avatar.png',
        content_type: 'image/png'
      )
    end
  end
end