ActiveAdmin.register Book do
  permit_params :checkbox, :title, :short_description, :price, :category_id, author_ids: []

  index do
    selectable_column
    id_column

    column :checkbox
    column :title
    column :short_description
    column :price
    column :authors do |book|
      book.authors.map { |author| [author.first_name, author.last_name] }.join('. ')
    end
    column :category

    actions
  end

  show do
    attributes_table do
      row :checkbox
      row :title
      row :short_description
      row :price
      row :category
      row :authors do |book|
        book.authors.map { |author| [author.first_name, author.last_name] }.join('. ')
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :checkbox
      f.input :short_description
      f.input :title
      f.input :price
      f.input :category
      f.input :authors
    end
    f.actions
  end
end
