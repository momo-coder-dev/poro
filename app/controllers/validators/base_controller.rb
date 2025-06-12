class Validators::BaseController < ApplicationController
	layout "validator"
	before_action :require_validator
	def require_validator
		redirect_to root_path unless current_validator
	end

	def current_validator
		@current_validator ||= Validator.find_by(id: session[:validator_id])
	end
end