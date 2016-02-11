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

class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :last_name, :email

  has_attached_file :avatar,
                    styles: { medium: '300x300#', thumb: '150x150#' },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def admin?
    admin
  end
end
