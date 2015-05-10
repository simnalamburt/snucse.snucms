require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @course = courses(:one)

    @admin = admins(:one)
    sign_in :admin, @admin
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post :create, course: { name: @course.name }
    end

    assert_redirected_to course_path(assigns(:course))
  end

  test "should show course" do
    get :show, id: @course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course
    assert_response :success
  end

  test "should update course" do
    patch :update, id: @course, course: { name: @course.name }
    assert_redirected_to course_path(assigns(:course))
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete :destroy, id: @course
    end

    assert_redirected_to courses_path
  end

  # Searching course test

  test 'course list should get result' do
    @user = users(:one)
    sign_in :user, @user

    get :index, format: 'json'
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal 6, json.length
  end

  test 'unauthenticated user cannot see course list' do
    get :index, format: 'json'
    assert_response 401
  end
end
