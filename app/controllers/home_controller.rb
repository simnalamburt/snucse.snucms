class HomeController < ApplicationController
  before_action :authenticate_user!

  def follow_course
    @course = Course.find_by id: params[:id]

    if current_user.courses.include? @course
      return render nothing: true, status: 409  # Conflict error
    end

    if @course.nil?
      return render nothing: true, status: 400
    end

    current_user.courses << @course
    render nothing: true
  end

  def unfollow_course
    @course = Course.find_by id: params[:id]

    if @course.nil? or not current_user.courses.include? @course
      return render nothing: true, status: 400
    end

    current_user.courses.delete @course

    render nothing: true
  end
end
