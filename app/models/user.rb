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
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google]

  validates :email, uniqueness: true
  validates_length_of :first_name, :last_name, minimum: 2, maximum: 35, allow_blank: false
  validates_length_of :email, minimum: 5, maximum: 35, allow_blank: false

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

  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
      user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        user.image = auth.info.image
        user.gender = getGender(auth.extra.raw_info.gender.to_s)
        user.nickname = auth.extra.raw_info.username
        user.status = true
        user.confirmed_at = Time.now
      end
    end
  end
end
