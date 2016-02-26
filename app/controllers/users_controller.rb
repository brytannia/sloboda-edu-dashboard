# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string           not null
#  last_name              :string           not null
#  speaker                :boolean
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class UsersController < ApplicationController
  before_action :profile_access, only: [:edit, :delete]

  def index
    # binding.pry
    if params[:key_word]
      @key = params[:key_word]
      @users = User.where('first_name LIKE ? OR last_name LIKE ? ',
                          "#{@key}%", "#{@key}%")
    else
      @users = User.order(:last_name)
    end
  end

  def show
    @user = User.find(params[:id].to_i)
  end

  def edit
    @user = User.find(params[:id].to_i)
  end

  def update
    @user = User.find(params[:id].to_i)
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def search
    @key = params[:key_word]
    @users = User.where('first_name LIKE ? OR last_name LIKE ? ',
                        "#{@key}%", "#{@key}%")
    render partial: 'users', key_word: @key, users: @users
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :phone, :title, :work_since, :desc)
  end

  def profile_access
    if current_user.nil?
      redirect_to root_path
    elsif current_user.id != params[:id].to_i
      redirect_to user_path(current_user)
    end
  end
end
