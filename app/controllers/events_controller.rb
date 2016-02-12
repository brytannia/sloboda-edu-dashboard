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
    @events = Event.order(:updated_at)
  end

  private

  def check_rights
    redirect_to new_user_session_path unless user_signed_in?
  end
end
