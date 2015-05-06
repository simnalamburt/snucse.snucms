class HomeController < ApplicationController
  before_action :authenticate_user!

  def follow_course
    @course = Course.find params[:id]

    if @course.nil? or current_user.course.include? @course
      return render nothing: true, status: 400
    end

    current_user.course << @course
    render nothing: true
  end

  def unfollow_course
    @course = Course.find params[:id]

    if @course.nil? or not current_user.course.delete @course
      return render nothing: true, status: 400
    end

    render nothing: true
  end
end
