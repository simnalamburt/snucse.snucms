class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :schedule
      t.belongs_to :user
      t.text :content

      t.timestamps null: false
    end
  end
end
