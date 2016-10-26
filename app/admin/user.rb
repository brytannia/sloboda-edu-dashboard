ActiveAdmin.register User do
  permit_params :first_name, :last_name, :speaker, :email,
                :password, :password_confirmation, :admin,
                :phone, :title, :work_since, :desc, :coworker

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
    column :email
    column :speaker
    column :admin
    column :coworker
    column :title
    column :phone
    column :work_since
    actions
  end

  form do |f|
    f.inputs 'User' do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :speaker
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.input :admin
      f.input :coworker
      f.input :title
      f.input :desc
      f.input :phone
      f.input :work_since, as: :datetime_picker
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :speaker
      row :admin
      row :coworker
      row :title
      row :phone
      row :desc
      row :work_since
    end
  end

  filter :speaker, as: :check_boxes
  filter :admin, as: :check_boxes
  filter :coworker, as: :check_boxes
end
