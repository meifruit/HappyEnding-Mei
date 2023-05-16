class ServicesController < ApplicationController
  def index
    @services = policy_scope(Service)
  end

  def show
    @service = Service.find(params[:id])
    authorize @service
  end

  def new
    @service = Service.new
    authorize @service
  end

  def create
    @service = Service.new(service_params)
    @service.user = current_user
    authorize @service
    if @service.save
      redirect_to service_path(@service)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def service_params
    params.require(:service).permit(:price, :description, :title, :user_id, :photo)
  end
end
