require "rails_helper"

describe "感想・レビューをナイスする" do
  let(:user) { create :user }
  let(:review) { create :review }
  before do
    login user
  end

  it "ナイス成功" do
    visit review_path(review)
    click_link I18n.t("link.register_like")
    expect(page).to have_content I18n.t("link.delete_like")
    expect(page).to have_content I18n.t("message.likes_count", count: 1)
  end
end

describe "感想・レビューのナイスを取り消す" do
  let(:user) { create :user }
  let(:review) { create :review }

  before do
    create(:like, user: user, review: review)
    login user
  end

  it "ナイス取り消しに成功" do
    visit review_path(review)
    click_link I18n.t("link.delete_like")
    expect(page).to have_content I18n.t("link.register_like")
    expect(page).to have_content I18n.t("message.likes_count", count: 0)
  end
end
