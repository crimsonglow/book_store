class ReviewPresenter < Rectify::Presenter
  attribute :current_book, Book

  COUNT_STARS = 5
  MIN_STARS = 1

  def all_comments
    current_book.comments
  end

  def is_verified?(review)
    t('book_page.review.verified_reviewer') if review.is_verified
  end

  def check_star(star, review)
    review.rating && star < review.rating ? 'rate-star' : 'star-not-checked'
  end
end
