class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :url
      t.string :crawling_type
      t.integer :course_id

      t.timestamps null: false
    end

    add_index :sites, :course_id
  end
end
