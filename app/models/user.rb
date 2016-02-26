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
  include Gravtastic
  gravtastic
  has_many :user_events
  has_many :events, through: :user_events
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  validates_length_of :first_name, :last_name, :email, minimum: 5, maximum: 35, allow_blank: false

  # getting user friendly url
  def to_param
    "#{id} #{first_name} #{last_name}".parameterize
  end

  def self.search(search)
    if search
      where('first_name LIKE ? OR last_name LIKE ?', "#{search}%", "#{search}%")
    else
      all
    end
  end
end
