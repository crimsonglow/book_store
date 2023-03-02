class HeaderPresenter < ApplicationPresenter
  attribute :current_order

  def all_categories
    Category.all
  end

  def count_books_in_cart
    return 0 unless current_order

    current_order.line_items.map(&:quantity).sum
  end
end
