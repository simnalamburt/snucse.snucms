class TimelineController < ApplicationController
  before_action :authenticate_user!
  layout false

  def index
    count = not(params[:count].nil?) ? params[:count].to_i : 10
    @timeline = current_user.timeline_initial count
  end

  def older_than
    offset = not(params[:offset].nil?) ? params[:offset].to_i : -1
    count = not(params[:count].nil?) ? params[:count].to_i : 10
    @ajax = params[:ajax] == "1"
    @timeline = current_user.timeline_older_than offset, count
    render 'index'
  end

  def since
    begin
      since_id = Integer(params[:since_id])
    rescue
      render 'index'
      return
    end

    @timeline = current_user.timeline_since since_id
    @ajax = true
    render 'index'
  end
end
