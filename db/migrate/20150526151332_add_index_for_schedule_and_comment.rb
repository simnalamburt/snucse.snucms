class AddIndexForScheduleAndComment < ActiveRecord::Migration
  def change
    add_foreign_key :schedules, :courses
    add_foreign_key :schedules, :users
    add_foreign_key :comments, :schedules
    add_foreign_key :comments, :users

    add_index :schedules, :course_id
    add_index :schedules, :user_id
    add_index :comments, :schedule_id
    add_index :comments, :user_id
  end
end
