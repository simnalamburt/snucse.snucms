class CalendarController < ApplicationController
  before_action :authenticate_user!
  layout false

  def index
  end

end
