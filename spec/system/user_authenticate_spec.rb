require "rails_helper"

describe "認証機能", type: :system do
  let(:user) { create :user }
  describe "アカウントを有効化してからログイン" do
    before do
      activate user
      visit login_path
      fill_in "session[email]", with: email
      fill_in "session[password]", with: password
      click_button I18n.t("title.login")
    end

    context "正しい値を入力した場合" do
      let(:email) { user.email }
      let(:password) { user.password }

      it "ログイン成功" do
        expect(page).to have_content I18n.t("flash.login_success")
        expect(page).to have_current_path profile_path
        expect(page).to have_content user.name
        expect(page).to have_content user.email
      end
    end

    context "email,password未入力の場合" do
      let(:email) { nil }
      let(:password) { nil }

      it "ログイン失敗" do
        expect(page).to have_content I18n.t("flash.login_failed")
      end
    end

    context "登録したユーザーのemailと不正passwordを入力した場合" do
      let(:email) { user.email }
      let(:password) { "foobar" }

      it "ログイン失敗" do
        expect(page).to have_content I18n.t("flash.login_failed")
      end
    end

    context "登録していないユーザーのemailとpasswordを入力した場合" do
      let(:email) { "user@invalid" }
      let(:password) { "foobar" }

      it "ログイン失敗" do
        expect(page).to have_content I18n.t("flash.login_failed")
      end
    end
  end

  describe "アカウントを有効化せずログイン" do
    before do
      visit login_path
      fill_in "session[email]", with: email
      fill_in "session[password]", with: password
      click_button I18n.t("title.login")
    end

    context "正しい値を入力した場合" do
      let(:email) { user.email }
      let(:password) { user.password }

      it "ログイン失敗" do
        expect(page).to have_content I18n.t("flash.login_failed")
        expect(page).to have_current_path root_path
      end
    end
  end

  describe "ログアウト" do
    it "ログアウト成功" do
      activate user
      login user
      click_link I18n.t("title.menu")
      click_link I18n.t("link.logout")
      expect(page).to have_content I18n.t("flash.logout_success")
      expect(page).to have_current_path root_path
    end
  end
end
