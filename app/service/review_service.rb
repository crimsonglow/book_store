class ReviewService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    return unless form.valid?

    create_review
  end

  def errors
    form.errors.full_messages.to_sentence
  end

  private

  def create_review
    attributes = form.attributes.without(:current_book, :current_user)
                     .merge(user_id: form.current_user, book_id: form.current_book)

    Review.create(attributes)
  end

  def form
    @form ||= ReviewForm.new(params)
  end
end
