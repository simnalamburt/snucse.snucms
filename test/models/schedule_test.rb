require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @course = courses(:one)
    @user = users(:one)
  end

  test "course has many schedule" do
    assert_equal 2, @course.schedules.count
    assert_equal 1, courses(:two).schedules.count
  end

  test "schedule should can be added" do
    schedule = Schedule.create(course: @course, user: @user, schedule_type: :exam, name: "중간고사", due_date: DateTime.now - 1.month, content: "중간고사")
    assert_equal 3, @course.reload.schedules.count
  end

  test "schedule can be removed" do
    assert_equal 2, @course.reload.schedules.count
    Schedule.where(course: @course).destroy_all
    assert_equal 0, @course.reload.schedules.count
  end
end
