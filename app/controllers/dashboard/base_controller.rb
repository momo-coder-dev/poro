class Dashboard::BaseController < Dashboard::AuthController
  layout "dashboard"
  include Pagy::Backend


end
  