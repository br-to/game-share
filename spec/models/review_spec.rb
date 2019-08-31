require "rails_helper"

RSpec.describe Review, type: :model do
  it "has a valid factory" do
    expect(build(:review)).to be_valid
  end

  describe "association" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:game) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe "delegate_method" do
    it { is_expected.to delegate_method(:name).to(:user).with_prefix(true) }
    it { is_expected.to delegate_method(:title).to(:game).with_prefix(true) }
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_most(255) }
  end
end
