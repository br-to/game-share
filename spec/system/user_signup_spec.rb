require "rails_helper"

describe "ユーザー登録", type: :system do
  let(:user) { build :user }
  let(:mail) { UserMailer.account_activation(user) }
  before do
    visit signup_path
    click_link I18n.t("title.new_registration")
    fill_in "user[name]", with: name
    fill_in "user[email]", with: email
    fill_in "user[password]", with: password
    fill_in "user[password_confirmation]", with: password_confirmation
    attach_file "user[image]", "#{Rails.root}/spec/fixtures/user.png"
    click_button I18n.t("title.register")
  end

  context "正しい値を入力した場合" do
    let(:name) { Faker::Name.name }
    let(:email) { Faker::Internet.unique.email }
    let(:password) { "password" }
    let(:password_confirmation) { "password" }

    it "登録成功" do
      expect(page).to have_content I18n.t("flash.mail_check")
      expect(page).to have_current_path root_path
    end

    it "メール送信成功" do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end

  context "nameが入力されていない場合" do
    let(:name) { nil }
    let(:email) { user.email }
    let(:password) { user.password }
    let(:password_confirmation) { user.password_confirmation }

    it "登録失敗" do
      expect(page).to have_content I18n.t("flash.registration_failed")
    end
  end

  context "不正なemailを入力した場合" do
    let(:name) { user.name }
    let(:email) { "user@invalid" }
    let(:password) { user.password }
    let(:password_confirmation) { user.password_confirmation }

    it "登録失敗" do
      expect(page).to have_content I18n.t("flash.registration_failed")
    end
  end

  context "不正なpasswordを入力した場合" do
    let(:name) { user.name }
    let(:email) { user.email }
    let(:password) { "abc" }
    let(:password_confirmation) { "abc" }

    it "登録失敗" do
      expect(page).to have_content I18n.t("flash.registration_failed")
    end
  end

  context "passwordとpassword_confirmationが違う値の場合" do
    let(:name) { user.name }
    let(:email) { user.email }
    let(:password) { "foobar" }
    let(:password_confirmation) { "foobbb" }

    it "登録失敗" do
      expect(page).to have_content I18n.t("flash.registration_failed")
    end
  end
end
