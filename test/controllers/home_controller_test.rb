require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  # Following course test

  test 'user can follow course that unfollowed' do
    user = users(:one)
    sign_in :user, user

    post :follow_course, {id: 1}
    assert_response :success

    post :follow_course, {id: 2}
    assert_response :success
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

  # Unfollowing course test

  test 'user can unfollow followed course' do
    user = users(:one)
    sign_in :user, user

    post :follow_course, {id: 1}
    post :follow_course, {id: 2}

    delete :unfollow_course, {id: 1}
    assert_response :success
  end

  test 'user cannot unfollow unfollowed course' do
    user = users(:one)
    sign_in :user, user

    post :follow_course, {id: 2}

    delete :unfollow_course, {id: 1}
    assert_response 400
  end

  test 'ser cannot unfollow invalid course' do
    user = users(:one)
    sign_in :user, user

    post :follow_course, {id: 1}

    delete :unfollow_course, {id: 'aaa'}
    assert_response 400
  end
end
