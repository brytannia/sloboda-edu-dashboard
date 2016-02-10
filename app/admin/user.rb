ActiveAdmin.register User do
  permit_params :first_name, :last_name, :speaker, :email,
    :password, :password_confirmation
  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :speaker
    column :email
    actions
  end
  form do |f|
    f.inputs "User" do
      f.input :first_name
      f.input :last_name
      f.input :speaker
      f.input :email
      f.input :admin
    end
    f.actions
  end

  filter :speaker, as: :check_boxes
  filter :admin, as: :check_boxes
end
