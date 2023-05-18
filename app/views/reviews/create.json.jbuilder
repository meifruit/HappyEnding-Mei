if @review.persisted?
  json.form render(partial: "reviews/form", formats: :html, locals: {service: @service, review: Review.new})
  json.inserted_item render(partial: "services/review", formats: :html, locals: {review: @review})
else
  json.form render(partial: "reviews/form", formats: :html, locals: {service: @service, review: @review})
end
