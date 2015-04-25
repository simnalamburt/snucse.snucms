require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers

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
end
