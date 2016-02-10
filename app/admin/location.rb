ActiveAdmin.register Location do
  permit_params :name, :address

  index do
    selectable_column
    column :id
    column :name
    column :address
    actions
  end
  form do |f|
    f.inputs "Location" do
      f.input :name
      f.input :address
    end
    f.actions
  end

  config.filters = false
end
