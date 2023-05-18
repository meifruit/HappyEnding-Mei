class ReviewsController < ApplicationController
  def create
    @service = Service.find(params[:service_id])
    @review = Review.new(review_params)
    @review.service = @service
    if @review.save
      redirect_to service_path(@service)
    else
      render "services/show", status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :user_id, :service_id)
  end
end
