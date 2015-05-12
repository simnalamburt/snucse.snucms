class RemoveDataColumnsFromLogsTable < ActiveRecord::Migration
  def change
    remove_column :logs, :full_data
    remove_column :logs, :data_hash
  end
end
