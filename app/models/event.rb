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
  after_update :send_updated_email, :request_speakers_update

  # template for different types of emails
  def send_email(run_at_time, email_type)
    event = Event.find(id)
    if event.try(:confirmed?)
      User.all.each do |user|
        UserMailer.delay(run_at: run_at_time)
                  .send(email_type, user, event)
      end
    end
  end

  def send_default_email
    if datetime.utc <= delay_time
      send_email(DateTime.now, 'instant_email')
    else
      send_email((datetime.utc.to_time - 3.hours).to_datetime,
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
    if datetime_changed?
      update_db
      if datetime.utc <= delay_time
        send_email(DateTime.now, 'instant_email')
      else
        send_email(DateTime.now, 'info_email')
        send_email((datetime.utc.to_time - 3.hours).to_datetime,
                   'notification_email')
      end
    end
  end

  # creates a delayed job for adding speakers labels
  def request_speakers_update
    event = Event.find(id)
    if event.try(:confirmed?)
      delay(run_at: event.datetime).add_speaker_labels(event)
    end
  end

  def add_speaker_labels(event)
    event.users.each do |u|
      u.update speaker: true
    end
  end

  def datetime_no_less_than_15_mins_before_now
    if !datetime.nil? && datetime.utc <= 15.minutes.from_now
      errors.add(:datetime, "can't be less than 15 minutes from now")
    end
  end

  private

  def delay_time
    3.hours.from_now
  end
end
