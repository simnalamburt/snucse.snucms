class CalendarController < ApplicationController
  before_action :authenticate_user!
  layout false

  def index
    begin
      @year = Integer(params[:year])
    rescue
      @year = Time.now.year
    end
    begin
      @month = Integer(params[:month])
    rescue
      @month = Time.now.month
    end

    @date = Date.new(@year, @month, 1)

    @prev_year = @month == 1 ? @year - 1: @year
    @prev_month = @month == 1 ? 12 : @month - 1

    @next_year = @month == 12 ? @year + 1 : @year
    @next_month = @month == 12 ? 1 : @month + 1

    @start_wday = @date.at_beginning_of_month.wday
    @last_day = ((@date + 1.month).at_beginning_of_month - 1.day).day
  end

end
