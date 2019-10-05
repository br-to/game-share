require "rails_helper"

describe "感想・レビュー編集", type: :system do
  let(:user) { create :user }
  let(:game) { create :game, user: user }

  describe "ネタバレなしレビュー編集" do
    let(:review) { create :review, game: game, user: user }

    before do
      activate user
      login user
      visit edit_review_path(review)
      fill_in "review[content]", with: content
      click_button I18n.t("title.edit")
    end

    context "正しい値を入力した場合" do
      let(:content) { Faker::Lorem.sentence }

      it "感想・レビュー編集成功" do
        expect(page).to have_content I18n.t("flash.review_update_success")
        expect(page).to have_content content
      end
    end

    context "不正なcontentを入力した場合" do
      let(:content) { nil }

      it "感想・レビュー編集失敗" do
        expect(page).to have_content I18n.t("flash.update_failed")
      end
    end
  end

  describe "ネタバレありレビュー編集" do
    let(:review) { create :review, is_spoiled: true, game: game, user: user }

    before do
      activate user
      login user
      visit edit_review_path(review)
      fill_in "review[content]", with: content
      click_button I18n.t("title.edit")
    end

    context "正しい値を入力した場合" do
      let(:content) { Faker::Lorem.sentence }

      it "ネタバレ編集成功" do
        expect(page).to have_content I18n.t("flash.review_update_success")
        expect(page).to have_content content
      end
    end

    context "不正なcontentを入力した場合" do
      let(:content) { nil }

      it "ネタバレ編集失敗" do
        expect(page).to have_content I18n.t("flash.update_failed")
      end
    end
  end
end
