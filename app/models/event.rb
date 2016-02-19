# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  subject     :string
#  confirmed   :boolean
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  datetime    :datetime
#

class Event < ActiveRecord::Base
  scope :upcoming, -> { where('datetime > ?', DateTime.now) }

  has_many :user_events
  has_many :users, through: :user_events
  belongs_to :location

  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :user_events
  validates_presence_of :subject
  validate :datetime_no_less_than_15_mins_before_now

  after_create :send_email
  after_update :send_email

  def send_email
    event = Event.find(id)
    event_time = (event.datetime.to_time - 3.hours).to_datetime
    users = User.all
    users.each do |u|
      UserMailer.delay(run_at: event_time)
                .notification_email(u, event)
    end
  end

  def datetime_no_less_than_15_mins_before_now
    if datetime <= 15.minutes.ago
      errors.add(:datetime, "can't be less than 15 minutes from now")
    end
  end
end
