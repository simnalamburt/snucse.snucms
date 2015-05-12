class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.binary :full_data
      t.string :hash
      t.string :message
      t.integer :site_id

      t.timestamps null: false
    end
    add_index :logs, :site_id
  end
end
