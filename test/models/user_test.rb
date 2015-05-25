require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:one)
  end

  test "timeline_initial" do
    @user.courses = [courses(:one), courses(:two)]
    timeline = @user.timeline_initial(2)
    assert_equal 2, timeline.count
    assert_equal 5, timeline[0].id
    assert_equal 4, timeline[1].id
  end

  test "timeline_older_than" do
    @user.courses = [courses(:one), courses(:two)]
    timeline = @user.timeline_older_than 5
    assert_equal 4, timeline.count
    timeline = @user.timeline_older_than 1
    assert_equal 0, timeline.count
  end

  test "timeline_since" do
    @user.courses = [courses(:one), courses(:two)]
    timeline = @user.timeline_since 1
    assert_equal 4, timeline.count
    timeline = @user.timeline_since 5
    assert_equal 0, timeline.count
  end
end
