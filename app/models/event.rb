class Event < ActiveRecord::Base
  has_many :user_events
  has_many :users, through: :user_events
  belongs_to :location

  accepts_nested_attributes_for :users, allow_destroy: true
  accepts_nested_attributes_for :user_events
  validates_presence_of :subject
end
