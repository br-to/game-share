class TopPageController < ApplicationController
  skip_before_action :authenticate_user

  def home
  end

  def help
  end
end
