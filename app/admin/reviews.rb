ActiveAdmin.register Review, as: 'BookReview' do
  permit_params :title, :text_review, :rating, :status, :is_verified, :user_id, :book_id

  actions :index, :show

  scope :unprocessed, default: true
  scope :approved
  scope :rejected

  config.filters = false

  index do
    selectable_column
    column :title
    column :text_review
    column :rating
    column :is_verified
    column :status
    column :user
    column :book

    actions
  end

  batch_action I18n.t('admin.approve'), if: proc { @current_scope.scope_method == :unprocessed } do |ids|
    reviews = Review.unprocessed.where(id: ids)
    reviews.any? ? reviews.each(&:approved!) : flash[:error] = I18n.t('admin.error')
    redirect_to(admin_book_reviews_path)
  end

  batch_action I18n.t('admin.reject'), if: proc { @current_scope.scope_method == :unprocessed } do |ids|
    reviews = Review.unprocessed.where(id: ids)
    reviews.any? ? reviews.each(&:rejected!) : flash[:error] = I18n.t('admin.error')
    redirect_to(admin_book_reviews_path)
  end

  batch_action I18n.t('admin.destroy') do |ids|
    reviews = Review.where(id: ids)
    reviews.any? ? reviews.destroy_all : flash[:error] = I18n.t('admin.error')
    redirect_to(admin_book_reviews_path)
  end
end
