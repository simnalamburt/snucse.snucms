require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @schedule = schedules(:one)
    @user = users(:one)
  end

  test "each schedule has comments" do
    assert_equal 3, @schedule.comments.count
    assert_equal 2, schedules(:two).comments.count
    assert_equal 3, @user.comments.count
  end

  test "add comment to schedule" do
    Comment.create!(schedule: @schedule, user: @user, content: "comment")
    assert_equal 4, @schedule.reload.comments.count
  end

  test "remove comment of schedule" do
    @schedule.comments[0].destroy
    assert_equal 2, @schedule.comments.count

    Comment.where(user: users(:two)).destroy_all
    assert_equal 0, users(:two).comments.count
  end
end
