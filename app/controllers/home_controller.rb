class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def course_list
    courses = Course.all
    render json: courses.map {|c| {'id': c.id, 'title' => c.name}}
  end
end
