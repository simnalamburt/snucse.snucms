class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def course_list
    courses = Course.all
    render json: courses.map { |c| { id: c.id, title: c.name } }
  end

  def follow_course
    @course = Course.find_by_id(params[:id])
    return render nothing: true, status: 400 if @course.nil?

    return render nothing: true, status: 409 if current_user.course.include? @course

    current_user.course << @course

    render json: current_user.course.map { |c| { id: c.id, title: c.name } }
  end

  def unfollow_course
    @course = Course.find_by_id(params[:id])
    return render nothing: true, status: 400 if @course.nil?

    return render nothing: true, status: 400 if not current_user.course.include? @course

    current_user.course.delete(@course)

    render json: current_user.course.map { |c| { id: c.id, title: c.name } }
  end
end
