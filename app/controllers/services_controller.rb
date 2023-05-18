class ServicesController < ApplicationController
  def index
    @services = policy_scope(Service)
    if params[:query].present?
      @services = Service.global_search(params[:query])
    else
      @services = Service.all
    end

    if params[:min_price].present? && params[:max_price].present?
      @services = @services.filter_by_price(params[:min_price].to_i, params[:max_price].to_i)
    end

    if @services.empty?
      flash.now[:notice] = "0 results"
    end
  end

  def show
    @service = Service.find(params[:id])
    @booking = Booking.new
    authorize @service
    @marker = [{
      lat: @service.user.geocode[0],
      lng: @service.user.geocode[1]
    }]
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
