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
  validates_presence_of :subject, :datetime, :location
  validate :datetime_no_less_than_15_mins_before_now

  after_create :send_default_email
  after_update :update_db, :send_updated_email

  def send_email(run_at_time, email_type)
    event = Event.find(id)
    if event.try(:confirmed?)
      users = User.all
      users.each do |user|
        UserMailer.delay(run_at: run_at_time)
                  .send(email_type, user, event)
      end
    end
  end

  def send_default_email
    if datetime - 2.hours <= 3.hours.from_now + 2.hours
      send_email(DateTime.now, 'instant_email')
    else
      send_email((datetime.to_time - 3.hours).to_datetime,
                 'notification_email')
    end
  end

  def update_db
    jobs = Delayed::Job.all
    jobs.each do |job|
      job.delete if job.handler.include? id.to_s
    end
  end

  def send_updated_email
    if datetime - 2.hours <= 3.hours.from_now + 2.hours
      send_email(DateTime.now, 'instant_email')
    else
      send_email(DateTime.now, 'info_email')
      send_email((datetime.to_time - 3.hours).to_datetime,
                 'notification_email')
    end
  end

  def datetime_no_less_than_15_mins_before_now
    if !datetime.nil? && datetime <= 15.minutes.from_now - 2.hours
      errors.add(:datetime, "can't be less than 15 minutes from now")
    end
  end
end
