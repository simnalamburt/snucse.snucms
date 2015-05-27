class AddDueTimeColumnInSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :due_time, :string
  end
end
