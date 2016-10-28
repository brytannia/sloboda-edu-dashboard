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
         :omniauthable, :omniauth_providers => [:facebook, :google, :github]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :password, :password_confirmation, presence: true, on: :create
  validates :password, confirmation: true
  validates_length_of :first_name, :last_name, minimum: 2, maximum: 35, allow_blank: false
  validates_length_of :email, minimum: 5, maximum: 35, allow_blank: false

  before_validation do
    if uid.blank?
      self.uid = email
      self.provider = "email"
    end
  end
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
        user.first_name = (auth.info.key?(:first_name) ? auth.info.first_name : auth.info.name.split[0])
        lastname = auth.info.name.split(" ")
        lastname.delete(user.first_name)
        lastname = lastname.join(" ")
        user.last_name = (auth.info.key?(:last_name) ? auth.info.last_name : lastname)
      end
    end
  end
end
