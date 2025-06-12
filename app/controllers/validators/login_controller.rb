class Validators::LoginController < ApplicationController

    layout false # ou un layout minimal si nécessaire

    def show
      @validator = Validator.find_by(id: params[:access_token])

      if @validator
        session[:validator_id] = @validator.id
        redirect_to validators_dashboard_home_path
      else
        render plain: "Access denied", status: :unauthorized
      end
    end
end