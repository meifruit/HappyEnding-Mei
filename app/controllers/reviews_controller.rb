class ReviewsController < ApplicationController
  def create
    @service = Service.find(params[:service_id])
    @review = Review.new(review_params)
    @review.service = @service
    @review.user = current_user
    authorize @review
    if @review.save
      redirect_to service_path(@service)
    else
      @reviews = @service.reviews
      @booking = Booking.new
      @current_user_bookings = policy_scope(Booking.where(user: current_user))
      @none_rejected_bookings = current_user.bookings_as_owner.pending
      @other_bookings = current_user.bookings_as_owner do |booking|
        booking.status != "pending"
      end
      @pending_bookings = current_user.bookings.pending
      render "bookings/index", status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :user_id, :service_id)
  end
end
