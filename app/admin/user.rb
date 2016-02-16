ActiveAdmin.register User do
  permit_params :first_name, :last_name, :speaker, :email,
                :password, :password_confirmation

  before_filter :set_role, only: [:create, :update]

  controller do
    def set_role
      @user = User.find(params[:id])
      @user.admin = params[:user][:admin] == '1' ?
        true : false
      @user.save
    end
  end

  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :speaker
    column :email
    column :admin
    actions
  end

  form do |f|
    f.inputs 'User' do
      f.input :first_name
      f.input :last_name
      f.input :avatar
      f.input :speaker
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :admin
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :speaker
      row :email
      row :admin
    end
  end

  filter :speaker, as: :check_boxes
  filter :admin, as: :check_boxes
end
