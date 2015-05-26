class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.belongs_to :course
      t.belongs_to :user
      t.integer :schedule_type
      t.text :content
      t.datetime :due_date
      t.string :name
      t.timestamps null: false
    end
  end
end
