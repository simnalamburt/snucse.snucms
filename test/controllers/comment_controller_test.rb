require 'test_helper'

class CommentControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in :user, @user
  end

  test 'user can comment in schedule' do
    assert_difference('Comment.count', 1) do
      post :create, schedule_id: 1, comment: {content: 'something'}
      assert_response :success
    end
  end

  test 'comment content cannot be empty' do
    assert_no_difference('Comment.count') do
      post :create, schedule_id: 1, comment: {content: ''}
      assert_response 400
    end
  end
end
