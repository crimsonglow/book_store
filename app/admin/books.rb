ActiveAdmin.register Book do
  permit_params :title, :description, :price, :category_id, :image, author_ids: []

  index do
    selectable_column
    id_column

    column :title
    column :description
    column :price do |book|
      I18n.t('admin.price_book', price: book.price)
    end
    column :authors do |book|
      book.authors.map(&:full_name).join(', ')
    end
    column :category

    actions
  end

  show do
    attributes_table do
      row :title
      row :author do |book|
        book.authors.map(&:full_name).join(', ')
      end
      row :category
      row :description
      row :published_year
      row :heigth
      row :width
      row :depth
      row :material
      row :price do |book|
        I18n.t('admin.price_book', price: book.price)
      end
      row :image do |book|
        image_tag book.image_url
      end
    end
  end

  form(html: { multipart: true }) do |f|
    f.inputs I18n.t('admin.add_edit_article') do
      f.input :title
      f.input :authors, as: :check_boxes
      f.input :category, as: :radio
      f.input :description
      f.input :published_year
      f.input :heigth
      f.input :width
      f.input :depth
      f.input :material
      f.input :price
      f.input :image, required: true, as: :file
    end
    actions
  end
end


