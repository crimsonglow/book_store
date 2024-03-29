ActiveAdmin.register Author do
  permit_params :first_name, :last_name, :description

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :description

    actions
  end
end
