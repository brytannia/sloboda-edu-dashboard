class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def is_admin?
    self.admin
  end
end
