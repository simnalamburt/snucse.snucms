class ChangeLogTableHashColumnToDataHash < ActiveRecord::Migration
  def change
    rename_column :logs, :hash, :data_hash
  end
end
