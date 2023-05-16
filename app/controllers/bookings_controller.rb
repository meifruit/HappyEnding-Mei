class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @service = Service.find(params[:service_id])
    authorize @booking
  end

  def index
    @current_user_bookings = policy_scope(Booking.where(user: current_user))
  end

  def create
    @booking = Booking.new(booking_params)
    @user = current_user
    @service = Service.find(params[:service_id])
    @booking.user = @user
    @booking.service = @service
    authorize @booking
    if @booking.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    if @booking.update(booking_params)
      redirect_to booking_path(@booking)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:status, :user_id, :service_id, :start_date, :end_date)
  end
end
