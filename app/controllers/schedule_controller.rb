class ScheduleController < ApplicationController
  def create
    @course = Course.find(params[:course_id])
    @schedule = @course.schedules.create(schedule_params)
    redirect_to #somewhere
  end

  private
  def schedule_params
    params.require(:schedule).permit()
end
