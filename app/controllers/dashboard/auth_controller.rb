class Dashboard::AuthController < ApplicationController
  before_action :authenticate_user!

  helper_method :current_account
  helper_method :current_user

  def current_account
    @current_account ||= current_user.accounts.first
  end
end
