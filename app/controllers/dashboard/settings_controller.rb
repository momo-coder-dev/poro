class Dashboard::SettingsController < Dashboard::BaseController
  def index
    @setting = current_account.account_setting
  end
end
