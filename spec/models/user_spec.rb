require "rails_helper"

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "email addresses should be saved as lower-case" do
    @user.save!
    expect(@user.reload.email).to eq @user.email.downcase
  end

  describe "association" do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:games).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:liked_review).through(:likes).source(:review) }
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_presence_of(:email) }
    it { expect(build(:user)).to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to have_secure_password }
  end
end
