ActiveAdmin.register BookImage do
  permit_params :image, :image_type, :book_id

  index do
    selectable_column

    column :image do |img|
      image_tag img.image_url(:small)
    end

    column :book do |img|
      Book.find_by(id: BookImage.find_by(id: img.id).book_id)
    end
    column :image_type

    actions
  end

  show do
    attributes_table do
      row :book do |img|
        Book.find_by(id: BookImage.find_by(id: img.id).book_id)
      end

      row :image do |img|
        image_tag img.image_url(:small)
      end
      row :image_type
    end
  end

  form(html: { multipart: true }) do |f|
    f.inputs I18n.t('admin.add_edit_article') do
      f.input :book
      f.input :image, required: true, as: :file
      f.input :image_type, as: :radio
    end
    actions
  end
end
