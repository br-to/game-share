require "rails_helper"

RSpec.describe Comment, type: :model do
  it "has a valid factory" do
    expect(build(:comment)).to be_valid
  end

  describe "association" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:review) }
  end

  describe "delegate_method" do
    it { is_expected.to delegate_method(:name).to(:user).with_prefix(true) }
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_most(150) }
  end
end
