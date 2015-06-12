class ScheduleController < ApplicationController
  before_action :authenticate_user!
  layout false

  def show
    @schedule = Schedule.find_by id: params[:id]
    @comment = Comment.new

    if @schedule.nil?
      render status: :not_found, nothing: true
      return
    end
  end

  def new
    begin
      @due_date = Date.parse(params[:due_date])
    rescue
      render status: 400, json: {msg: 'Invalid date'}
    end
    @schedule = Schedule.new
  end

  def create
    param = schedule_params

    begin
      param['due_date'] = Date.parse(params['due_date'])
    rescue
      render status: 400, json: {msg: 'Invalid date'}
      return
    end
    param['course'] = Course.find_by id: param['course']

    if not current_user.courses.include? param['course'] then
      render status: 400, json: {msg: 'unfollow course'}
      return
    end
    param['user'] = current_user

    param.permit!
    @schedule = Schedule.new(param)

    if @schedule.save
      render status: 200, nothing: true
    else
      render status: 400, json: {msg: 'Adding schedule had problem'}
    end
  end

  def destroy
    @schedule = Schedule.find_by id: params[:id]
    if @schedule.user != current_user then
      render status: :forbidden, json: {msg: 'Incorrect user'}
      return
    end

    @schedule.destroy
    render status: :ok, nothing: true
  end

  def schedule_params
    params.require(:schedule).permit(:course, :user, :name, :content, :due_date, :schedule_type, :due_time)
  end
end
