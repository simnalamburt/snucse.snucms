require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @course = courses(:one)
    @user = users(:one)
  end

  teardown do
    Date.unstub(:today)
  end

  test "course has many schedule" do
    assert_equal 3, @course.schedules.count
    assert_equal 1, courses(:two).schedules.count
  end

  test "schedule should can be added" do
    @course.schedules.create!(user: @user, schedule_type: :exam, name: "중간고사", due_date: DateTime.now - 1.month, content: "중간고사")
    assert_equal 4, @course.reload.schedules.count
  end

  test "schedule can be removed" do
    assert_equal 3, @course.reload.schedules.count
    Schedule.where(course: @course).destroy_all
    assert_equal 0, @course.reload.schedules.count
  end

  test "schedule of month" do
    @user.courses << courses(:one)
    Date.stubs(:today).returns(Date.new(2015, 5, 1))
    assert_equal 2, Schedule.of_month(@user).length
    assert_equal 2, Schedule.of_month(@user, 2015, 5).length
    assert_equal 0, Schedule.of_month(@user, 2015, 6).length
  end
end
