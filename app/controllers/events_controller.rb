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

class EventsController < ApplicationController
  before_action :check_rights

  def index
    events = Event.order(:datetime).where('datetime < ?', DateTime.now)
    @hash = {}
    events.each do |e|
      unless @hash.key? e.datetime.try(:strftime, '%B')
        @hash[e.datetime.try(:strftime, '%B')] = []
      end
      @hash[e.datetime.try(:strftime, '%B')] << e
    end
  end

  private

  def check_rights
    redirect_to new_user_session_path unless user_signed_in?
  end
end
