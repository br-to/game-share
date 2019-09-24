module LoginHelper
  def login(user)
    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button I18n.t("title.login")
  end

  def activate(user)
    user.activation_token = User.new_token
    visit edit_account_activation_path(user.activation_token, email: user.email)
    user.update!(activated: true)
  end
end
