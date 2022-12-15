class CompletePresenter < ApplicationPresenter
  attribute :params
  attribute :current_order
  STEP = :complete
end
