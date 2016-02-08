class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def is_admin?
    self.email && ENV['ADMIN_EMAILS'].to_s.include?(self.email)
  end
end
