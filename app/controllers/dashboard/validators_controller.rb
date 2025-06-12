class Dashboard::ValidatorsController < Dashboard::BaseController
  before_action :set_validator, only: [:show, :edit, :update, :destroy]

  def index
    @validators = Validator.all
  end

  def show
  end

  def new
    @validator = Validator.new
  end

  def create
    @validator = Validator.new(validator_params)
    @validator.generate_access_token

    if @validator.save
      redirect_to dashboard_validator_path(@validator), notice: 'Validator was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @validator.update(validator_params)
      redirect_to dashboard_validator_path(@validator), notice: 'Validator was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @validator.destroy
    redirect_to dashboard_validators_path, notice: 'Validator was successfully deleted.'
  end

  private

  def set_validator
    @validator = Validator.find(params[:id])
  end

  def validator_params
    params.require(:validator).permit(
      :name,
      :email,
      :phone,
      :event_id,
      ticket_type_ids: []
    )
  end
end 