ActiveAdmin.register User do
  permit_params :first_name, :last_name, :speaker, :email,
    :password, :password_confirmation
  form do |f|
    f.inputs "User" do
      f.input :first_name
      f.input :last_name
      f.input :speaker
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
