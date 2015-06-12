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

  test 'own comment can destroy' do
    post :create, schedule_id: 1, comment: {content: 'some_comment'}
    comment = Comment.find_by(schedule_id: 1, content: 'some_comment')

    assert_difference('Comment.count', -1) do
      delete :destroy, schedule_id: 1, id: comment.id
      assert_response :ok
    end
  end

  test 'invalid comment cannot destory' do
    post :create, schedule_id: 1, comment: {content: 'some_comment'}
    comment = Comment.find_by(schedule_id: 1, content: 'some_comment')

    assert_no_difference('Comment.count') do
      delete :destroy, schedule_id: 1, id: comment.id + 150
      assert_response :not_found
    end
  end

  test 'other\'s comment cannot destory' do
    post :create, schedule_id: 1, comment: {content: 'some_comment'}
    comment = Comment.find_by(schedule_id: 1, content: 'some_comment')

    sign_out :user
    sign_in :user, users(:two)

    assert_no_difference('Comment.count') do
      delete :destroy, schedule_id: 1, id: comment.id
      assert_response :forbidden
    end
  end
end
