module LoginHelper
  def login(user)
    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button I18n.t("title.login")
  end
end
