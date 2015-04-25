class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def course_list
    courses = Course.all
    render json: courses.map {|c| {'title' => c.name}}
  end
end
