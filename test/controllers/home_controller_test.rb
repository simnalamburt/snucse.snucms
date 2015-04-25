require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  # Searching course test

  test 'course list should get result' do
    @user = users(:one)
    sign_in :user, @user

    get :course_list
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal 6, json.length
  end

  test 'unauthenticated user cannot see course list' do
    get :course_list
    assert_response :redirect
  end

  # Following course test

  test 'user can follow course that unfollowed' do
    user = users(:one)
    sign_in :user, user

    post :follow_course, {id: 1}
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal 1, json.length
    assert_equal 1, json[0]['id']

    post :follow_course, {id: 2}
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal 2, json.length
    assert json.map{ |j| j['id'] }.include? 1
    assert json.map{ |j| j['id'] }.include? 2
  end

  test 'followed course cannot follow again' do
    user = users(:one)
    sign_in :user, user

    post :follow_course, {id: 1}
    assert_response :success

    post :follow_course, {id: 1}
    assert_response 409  # conflict error
  end

  test 'invalid course id cannot be followed' do
    user = users(:one)
    sign_in :user, user

    post :follow_course, {id: 'aa'}
    assert_response 400

    post :follow_course, {id: 10}
    assert_response 400
  end
end
