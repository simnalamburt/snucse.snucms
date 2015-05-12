class TimelineController < ApplicationController
  before_action :authenticate_user!
  layout false

  def index
    count = params[:count] || 10
    @timeline = current_user.timeline_initial count
  end
end
