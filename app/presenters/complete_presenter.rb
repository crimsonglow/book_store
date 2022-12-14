class CompletePresenter < Rectify::Presenter
  attribute :params
  attribute :current_order
  STEP = :complete

  def main_image_or_default(item)
    BookImageQuery.new.main_image_or_default(item.book)
  end
end
