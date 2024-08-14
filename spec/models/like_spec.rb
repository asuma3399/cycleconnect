require 'rails_helper'

RSpec.describe Like, type: :model do
  # belongs_to :post
  it { is_expected.to belong_to(:post) }

  # belongs_to :user
  it { is_expected.to belong_to(:user) }
end
