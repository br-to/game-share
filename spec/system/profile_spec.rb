require "rails_helper"

describe "プロフィール", type: :system do
  describe "ユーザー編集" do
    let(:user) { create :user }
    before do
      login user
      visit edit_profile_path(user)
      fill_in "user[name]", with: name
      fill_in "user[email]", with: email
      fill_in "user[password]", with: password
      fill_in "user[password_confirmation]", with: password_confirmation
      attach_file "user[user_picture]", "#{Rails.root}/spec/fixtures/user2.png"
      click_button I18n.t("title.edit")
    end

    context "正しい値を入力した場合" do
      let(:name) { Faker::Name.name }
      let(:email) { Faker::Internet.unique.email }
      let(:password) { "password" }
      let(:password_confirmation) { "password" }

      it "編集成功" do
        expect(page).to have_content I18n.t("flash.user_update_success")
        expect(page).to have_content name
        expect(page).to have_content email
        expect(page).to have_selector("img[src$='user2.png']")
      end
    end

    context "nameが入力されていない場合" do
      let(:name) { nil }
      let(:email) { user.email }
      let(:password) { user.password }
      let(:password_confirmation) { user.password_confirmation }

      it "編集失敗" do
        expect(page).to have_content I18n.t("flash.update_failed")
      end
    end

    context "不正なemailを入力した場合" do
      let(:name) { user.name }
      let(:email) { "user@invalid" }
      let(:password) { user.password }
      let(:password_confirmation) { user.password_confirmation }

      it "編集失敗" do
        expect(page).to have_content I18n.t("flash.update_failed")
      end
    end

    context "不正なpasswordを入力した場合" do
      let(:name) { user.name }
      let(:email) { user.email }
      let(:password) { "abc" }
      let(:password_confirmation) { "abc" }

      it "編集失敗" do
        expect(page).to have_content I18n.t("flash.update_failed")
      end
    end

    context "passwordとpassword_confirmationが違う値の場合" do
      let(:name) { user.name }
      let(:email) { user.email }
      let(:password) { "foobar" }
      let(:password_confirmation) { "foobbb" }

      it "編集失敗" do
        expect(page).to have_content I18n.t("flash.update_failed")
      end
    end
  end

  describe "ユーザー削除" do
    let(:user) { create(:user) }

    it "ユーザー削除成功" do
      login user
      visit profile_path
      click_link I18n.t("link.delete_user")
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_current_path root_path
      expect(page).to have_content I18n.t("flash.user_destroy_success")
    end
  end
end
