class AddProfColumnOnCoursesTable < ActiveRecord::Migration
  def change
    add_column :courses, :prof, :string
  end
end
