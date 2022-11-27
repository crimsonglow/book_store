class ReviewService
  attr_reader :reviews_form_params

  def initialize(reviews_form_params)
    @reviews_form_params = reviews_form_params
  end

  def save_review
    return unless review_form.valid?

    create_review
  end

  def reviews_errors
    review_form.errors.full_messages.to_sentence
  end

  private

  def create_review
    attributes = review_form.attributes.without(:current_book, :current_user)
                            .merge(user_id: review_form.current_user, book_id: review_form.current_book)

    Review.create(attributes)
  end

  def review_form
    @review_form ||= ReviewForm.new(reviews_form_params)
  end
end
