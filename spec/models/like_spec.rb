require "rails_helper"

RSpec.describe Like, type: :model do
  it "has a valid factory" do
    expect(build(:like)).to be_valid
  end

  describe "association" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:review) }
  end
end
