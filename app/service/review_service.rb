class ReviewService < ApplicationController
  attr_reader :review_form

  def initialize(reviews_form_params)
    @review_form = ReviewForm.new(reviews_form_params)
  end

  def save_review
    create_review if review_form.valid?
  end

  private

  def create_review
    attributes = review_form.attributes.without(:current_book, :current_user)
                                       .merge(user_id: review_form.current_user, book_id: review_form.current_book)

    Review.create(attributes)
  end
end
