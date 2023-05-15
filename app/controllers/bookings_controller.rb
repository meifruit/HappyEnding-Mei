class BookingsController < ApplicationController

  def new
    @booking = Booking.new
    @service = Service.find(params[:service_id])
  end

  def create
    @booking = Booking.new(params_booking)
    @user = current_user
    @service = Sercvice.new(params[:service_id])
    @booking.user = @user
    @booking.service = @service
    if @booking.save
      redirect_to service_path(Service.find(params[:service_id]))
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def params_booking
    params.require(:booking).permit(:user_id, :service_id, :start_date, :end_date)
  end

end
