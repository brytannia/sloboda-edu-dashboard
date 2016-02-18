class Event < ActiveRecord::Base
  has_many :user_events
  has_many :users, through: :user_events
  belongs_to :location

  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :user_events
  validates_presence_of :subject

  after_create :send_email
  after_update :send_email

  def send_email
    event = Event.find(id)
    # event_time = (event.datetime.to_time - 3.hours).to_datetime
    UserMailer.delay(run_at: 2.seconds.from_now)
              .notification_email(User.last, event)
  end
end
