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

  after_create :send_default_email
  after_update :update_db, :send_updated_email

  def send_email(run_at_time, email_type)
    event = Event.find(id)
    if event.try(:confirmed?)
      # event_time = (event.datetime.to_time - 3.hours).to_datetime
      users = User.all
      users.each do |user|
        UserMailer.delay(run_at: run_at_time)
                  .send(email_type, user, event)
      end
    end
  end

  def send_default_email
    datetime >= 3.hours.from_now ? send_email(2.minutes.from_now, 'notification_email')
                           : send_email(DateTime.now, 'instant_email')
  end

  def update_db
  end

  def send_updated_email
    if datetime >= 3.hours.from_now
      send_email(DateTime.now, 'info_email')
      send_email(2.minutes.from_now, 'notification_email')
    else
      send_email(DateTime.now, 'instant_email')
    end
  end

  def datetime_no_less_than_15_mins_before_now
    if !datetime.nil? && datetime <= 15.minutes.from_now
      errors.add(:datetime, "can't be less than 15 minutes from now")
    end
  end
end
