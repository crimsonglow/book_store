class ReviewsController < ApplicationController
  def create
    authorize :review, :create?

    review_service = ReviewService.new(reviews_form_params)

    if review_service.save_review
      flash[:success] = t('book_page.review.success_add_comment')
    else
      flash[:error] = review_service.reviews_errors
    end
    redirect_to book_path(params[:current_book])
  end

  private

  def reviews_form_params
    params.permit(:title, :text_review, :rating, :current_user, :current_book)
  end
end
