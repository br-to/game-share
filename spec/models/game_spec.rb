require "rails_helper"

RSpec.describe Game, type: :model do
  it "has a valid factory" do
    expect(build(:game)).to be_valid
  end

  describe "association" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(50) }
  end
end
