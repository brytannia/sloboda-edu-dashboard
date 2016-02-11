class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :last_name, :email,
                        :password, :password_confirmation

  def admin?
    admin
  end
end
